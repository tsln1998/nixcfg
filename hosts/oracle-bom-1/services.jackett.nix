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
  workdir = "/var/lib/jackett";
in
{
  # jackett with litestream services
  services.jackett = {
    enable = true;
    package = pkgs.unstable.jackett;
    dataDir = workdir;
  };

  systemd.services.jackett = {
    after = [
      "network.target"
      "rclone-mount-jackett-sync.service"
    ];
    requires = [
      "network.target"
      "rclone-mount-jackett-sync.service"
    ];
  };

  # rclone mount cloudflare r2 on syncdir (persistent directory)
  services.rclone.enable = true;
  services.rclone.mounts.jackett-sync = {
    configFile = secrets."hosts/${hostName}/jackett-sync.rclone".path;
    remote = "r2";
    public = true;
    subpath = "fs-jackett";
    local = workdir;
    vfs-cache = {
      max-age = "1h";
      max-size = "16M";
      write-back = "1m";
    };
  };
}
