{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.xdg) cacheHome;
  inherit (config.home) homeDirectory;

  directory = "onedrive";
  mountpoint = "${homeDirectory}/${directory}";
in
{
  home.packages = [
    pkgs.onedriver
  ];

  xdg.configFile = {
    "onedriver/config.yml" = {
      text = ''
        log: info
        cacheDir: ${cacheHome}/${directory}
      '';
    };
  };

  home.activation = {
    onedriver-initializer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p ${lib.escapeShellArg mountpoint}
    '';
  };

  systemd.user.services = {
    onedriver = {
      Unit = {
        Description = "OneDrive FUSE mount";
        Wants = [ "network-online.target" ];
        After = [ "network-online.target" ];
      };

      Service = {
        ExecStart = "${pkgs.onedriver}/bin/onedriver ${mountpoint}";

        ExecStop = "${pkgs.fuse3}/bin/fusermount3 -uz ${mountpoint}";

        Restart = "on-failure";
        RestartSec = 3;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
