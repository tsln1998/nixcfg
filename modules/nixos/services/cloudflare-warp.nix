{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.cloudflare-warp;
  cli = pkgs.writeShellScript "warp-cli-tos" ''
    ${lib.getExe cfg.package} --accept-tos $@
  '';
  connect = pkgs.writeShellScript "cloudflare-warp-connect" ''
    ${cli} registration show || ${cli} registration new
    ${cli} mode ${cfg.mode}
    ${cli} connect
  '';
  disconnect = pkgs.writeShellScript "cloudflare-warp-disconnect" ''
    ${cli} disconnect
  '';
in
{
  options.services.cloudflare-warp = {
    mode = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "warp"
          "warp+doh"
          "warp+dot"
          "proxy"
          "tunnel_only"
          "doh"
          "dot"
        ]
      );
      default = null;
      description = "Cloudflare WARP connection mode";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.mode != null) {
    systemd.services.cloudflare-warp-automatic = {
      description = "Cloudflare WARP automatic registration and connection";
      wantedBy = [ "multi-user.target" ];
      requires = [ "cloudflare-warp.service" ];
      after = [ "cloudflare-warp.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = connect;
        ExecStop = disconnect;
      };
    };
  };
}
