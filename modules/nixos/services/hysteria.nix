{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.services.hysteria;
in
{
  options.services.hysteria = {
    enable = lib.mkEnableOption "Hysteria is a powerful, lightning fast and censorship resistant proxy.";

    package = lib.mkPackageOption pkgs "hysteria" { };

    configFile = lib.mkOption {
      type = lib.types.path;
      description = "Configuration file to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    ### systemd service
    systemd.services."hysteria" = {
      description = "Hysteria is a powerful, lightning fast and censorship resistant proxy.";
      documentation = [ "https://v2.hysteria.network/" ];
      requires = [ "network-online.target" ];
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = lib.concatStringsSep " " [
          (lib.getExe cfg.package)
          "server"
          "-c"
          "\${CREDENTIALS_DIRECTORY}/config.yaml"
        ];

        DynamicUser = true;
        StateDirectory = "hysteria";
        WorkingDirectory = "/var/lib/hysteria";
        LoadCredential = "config.yaml:${cfg.configFile}";
        AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
        CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
        CPUSchedulingPolicy = "rr";
        CPUSchedulingPriority = 99;
      };
    };
  };
}
