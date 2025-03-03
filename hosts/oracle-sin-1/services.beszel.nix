{ pkgs, config, ... }:
let
  inherit (config.age) secrets;
in
{
  services.beszel-hub = {
    enable = true;
    package = pkgs.beszel;
    address = "127.0.0.1:18091";
    after = [ "rclone-mount-beszel.service" ];
    superuser = {
      email = "tsln1998@gmail.com";
      passwordFile = secrets."hosts/oracle-sin-1/beszel.passwd".path;
    };
  };

  services.rclone = {
    enable = true;

    mounts.beszel = {
      configFile = secrets."hosts/oracle-sin-1/beszel.rclone".path;
      remote = "r2";
      subpath = "fs-beszel";
      local = config.services.beszel-hub.data;
      vfs-cache = {
        max-age = "1h";
        max-size = "16M";
        write-back = "15s";
       };
    };
  };
}
