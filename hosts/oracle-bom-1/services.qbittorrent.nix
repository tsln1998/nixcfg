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
  workdir = "/var/lib/qbittorrent";
  syncdir = "/var/lib/qbittorrent/qBittorrent";
in
{
  # qbittorrent
  systemd.services.qbittorrent = {
    description = "qBittorrent web service";
    after = [
      "network.target"
      "rclone-mount-qbittorrent-sync.service"
    ];
    requires = [
      "network.target"
      "rclone-mount-qbittorrent-sync.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "qbittorrent-exec" ''
        # create downloads directory
        ${pkgs.coreutils}/bin/mkdir -p ${workdir}/downloads
        ${pkgs.coreutils}/bin/chmod -R 0666 ${workdir}/downloads
        # start webui
        ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --profile=${workdir} --webui-port=6085
      '';
      Restart = "on-failure";
    };
  };

  # rclone mount cloudflare r2 on syncdir (persistent directory)
  services.rclone.enable = true;
  services.rclone.mounts.qbittorrent-sync = {
    configFile = secrets."hosts/${hostName}/qbittorrent-sync.rclone".path;
    remote = "r2";
    public = true;
    subpath = "fs-qbittorrent";
    local = syncdir;
    vfs-cache = {
      max-age = "1h";
      max-size = "16M";
      write-back = "1m";
    };
  };
}
