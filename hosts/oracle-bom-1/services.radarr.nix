{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  # runtime directory
  workdir = "/var/lib/radarr";
  syncdir = "${workdir}/sync";

  # runtime files
  workdb = "${workdir}/radarr.db";
  syncdb = "${syncdir}/db";

  # radarr config
  radarr-work-conf = "${workdir}/config.xml";
  radarr-sync-conf = "${syncdir}/config.xml";

  # radarr launcher
  radarr = "${pkgs.radarr}/bin/Radarr";
  radarr-exec = pkgs.writeShellScript "radarr-exec" (
    lib.concatStringsSep " " [
      radarr
      "-nobrowser"
      "-data=${workdir}"
    ]
  );

  # litestream launcher
  litestream = "${pkgs.litestream}/bin/litestream";
  litestream-conf = pkgs.writeText "radarr-litestream.yaml" ''
    exec: ${radarr-exec}
    dbs:
    - path:             ${workdb}
      replicas:
      - path:           ${syncdb}
        retention:      720h
  '';
in
{
  # radarr with litestream services
  systemd.services.radarr = {
    description = "radarr web server";
    after = [
      "network.target"
      "rclone-mount-radarr-sync.service"
    ];
    requires = [
      "network.target"
      "rclone-mount-radarr-sync.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = pkgs.writeShellScript "litestream-radarr-restore" ''
        ${pkgs.coreutils}/bin/mkdir -p ${workdir}
        ${pkgs.coreutils}/bin/cp ${radarr-sync-conf} ${radarr-work-conf} || true

        ${litestream} restore -if-db-not-exists -if-replica-exists -config ${litestream-conf} ${workdb}
      '';
      ExecStart = "${litestream} replicate -config ${litestream-conf}";
      Restart = "on-failure";
    };
  };

  # radarr config sync services
  systemd.services.radarr-config-sync = {
    description = "radarr config sync";
    after = [
      "network.target"
      "radarr.service"
    ];
    requires = [
      "network.target"
      "radarr.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "radarr-config-sync" ''
        ${pkgs.coreutils}/bin/cp ${radarr-work-conf} ${radarr-sync-conf} || true
      '';
    };
  };

  systemd.timers.radarr-config-sync-timer = {
    description = "radarr config sync timer";
    after = [
      "network.target"
      "radarr.service"
    ];
    requires = [
      "network.target"
      "radarr.service"
    ];
    wantedBy = [
      "timers.target"
    ];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "radarr-config-sync.service";
    };
  };

  # rclone mount cloudflare r2 on syncdir (persistent directory)
  services.rclone.enable = true;
  services.rclone.mounts.radarr-sync = {
    configFile = secrets."hosts/${hostName}/radarr-sync.rclone".path;
    remote = "r2";
    subpath = "fs-radarr";
    local = syncdir;
    vfs-cache = {
      max-age = "1h";
      max-size = "16M";
      write-back = "5s";
    };
  };
}
