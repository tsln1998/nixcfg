{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.crproxy;
in
{
  options.services.crproxy = {
    enable = lib.mkEnableOption "crproxy (image proxy)";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.additions.crproxy;
    };

    address = lib.mkOption {
      type = lib.types.str;
      default = ":8080";
      description = ''
        CRProxy served address
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      [
        cfg.package
      ]
      ++ [
        pkgs.procps
      ];

    systemd.services.crproxy = {
      description = "CRProxy daemon";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/crproxy --address ${cfg.address}";
        ExecStop = "${pkgs.procps}/bin/pkill crproxy";
        Restart = "on-failure";
      };
    };
  };
}
