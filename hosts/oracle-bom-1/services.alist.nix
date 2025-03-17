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
  ctrldir = "/mnt/alist";
  ctrldft = "aliyun";
  workdir = "/var/lib/alist";
  syncdir = "${workdir}/sync";

  # runtime files
  workdb = "${workdir}/data.db";
  syncdb = "${syncdir}/db";

  # alist config
  alist-work-conf = "${workdir}/config.json";
  alist-sync-conf = "${syncdir}/config.json";

  # alist launcher
  alist = "${pkgs.alist}/bin/alist";
  alist-exec = pkgs.writeShellScript "alist-exec" (
    lib.concatStringsSep " " [
      alist
      "--data"
      workdir
      "server"
    ]
  );

  # litestream launcher
  litestream = "${pkgs.litestream}/bin/litestream";
  litestream-conf = pkgs.writeText "alist-litestream.yaml" ''
    exec: ${alist-exec}
    dbs:
    - path:             ${workdb}
      replicas:
      - path:           ${syncdb}
        retention:      720h
  '';
in
{
  # alist with litestream services
  systemd.services.alist = {
    description = "alist web server";
    after = [
      "network.target"
      "rclone-mount-alist-sync.service"
    ];
    requires = [
      "network.target"
      "rclone-mount-alist-sync.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = pkgs.writeShellScript "litestream-alist-restore" ''
        [ -f "${alist-sync-conf}" ] && \
          ${pkgs.coreutils}/bin/cp ${alist-sync-conf} ${alist-work-conf}

        ${litestream} restore -if-db-not-exists -if-replica-exists -config ${litestream-conf} ${workdb}
      '';
      ExecStart = "${litestream} replicate -config ${litestream-conf}";
      Restart = "on-failure";
    };
  };

  # alist config sync services
  systemd.services.alist-config-sync = {
    description = "alist config sync";
    after = [
      "network.target"
      "alist.service"
    ];
    requires = [
      "network.target"
      "alist.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "alist-config-sync" ''
        [ -f "${alist-work-conf}" ] && \
          ${pkgs.coreutils}/bin/cp ${alist-work-conf} ${alist-sync-conf}
      '';
    };
  };

  systemd.timers.alist-config-sync-timer = {
    description = "alist config sync timer";
    after = [
      "network.target"
      "alist.service"
    ];
    requires = [
      "network.target"
      "alist.service"
    ];
    wantedBy = [
      "timers.target"
    ];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "alist-config-sync.service";
    };
  };

  # alist upload util
  environment.systemPackages = [(pkgs.writeScriptBin "alist-upload" ''
    INPUT="$1"
    OUTPUT="$2"
    ${pkgs.coreutils}/bin/cp -r "$INPUT" "${ctrldir}/${ctrldft}/$OUTPUT"
  '')];

  # rclone enable
  services.rclone.enable = true;

  # rclone mount cloudflare r2 on syncdir (persistent directory)
  services.rclone.mounts.alist-sync = {
    configFile = secrets."hosts/${hostName}/alist-sync.rclone".path;
    remote = "r2";
    subpath = "fs-alist";
    local = syncdir;
    vfs-cache = {
      max-age = "1h";
      max-size = "16M";
      write-back = "5s";
    };
  };

  # rclone mount alist webdav on local path
  services.rclone.mounts.alist-webdav = {
    configFile = secrets."hosts/${hostName}/alist-webdav.rclone".path;
    public = true;
    remote = "webdav";
    subpath = "/";
    local = ctrldir;
    vfs-cache = {
      max-age = "3h";
      max-size = "4G";
      write-back = "15s";
    };
  };
}
