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
  workdir = "/var/lib/nezha";
  syncdir = "${workdir}/sync";

  # runtime files
  workdb = "${workdir}/nezha.db";
  syncdb = "${syncdir}/db";

  # nezha launcher
  nezha = "${pkgs.unstable.nezha}/bin/nezha";
  nezha-conf = "${syncdir}/nezha.conf";
  nezha-exec = pkgs.writeShellScript "nezha-exec" (
    lib.concatStringsSep " " [
      nezha
      "-c"
      nezha-conf
      "-db"
      workdb
    ]
  );

  # litestream launcher
  litestream = "${pkgs.litestream}/bin/litestream";
  litestream-conf = pkgs.writeText "nezha-litestream.yaml" ''
    exec: ${nezha-exec}
    dbs:
    - path:             ${workdb}
      replicas:
      - path:           ${syncdb}
        retention:      720h
  '';

in
{
  systemd.services.nezha-dashboard = {
    description = "Nezha dashboard web service";
    after = [
      "network.target"
      "rclone-mount-nezha.service"
    ];
    requires = [
      "network.target"
      "rclone-mount-nezha.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStartPre = "${litestream} restore -if-db-not-exists -if-replica-exists -config ${litestream-conf} ${workdb}";
      ExecStart = "${litestream} replicate -config ${litestream-conf}";
      Restart = "on-failure";
    };
  };

  services.rclone = {
    enable = true;
    mounts.nezha = {
      configFile = secrets."hosts/${hostName}/nezha.rclone".path;
      remote = "r2";
      subpath = "fs-nezha";
      local = syncdir;
      vfs-cache = {
        max-age = "1h";
        max-size = "16M";
        write-back = "5s";
      };
    };
  };
}
