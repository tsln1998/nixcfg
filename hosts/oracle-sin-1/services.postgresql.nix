{
  lib, config,
  ...
}:
let
  # Import age secrets and hostname
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  # PostgreSQL Service
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    enableJIT = true;

    dataDir = "/var/lib/postgresql";

    authentication = ''
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  # PostgreSQL Backup Service
  services.postgresqlBackup = {
    enable = true;
    location = config.services.rclone.mounts.postgresql.local;
    compression = "gzip";
    compressionLevel = 9;
  };

  # Backup Filesystem
  services.rclone = {
    enable = true;
    mounts = {
      postgresql = {
        remote = "r2";
        subpath = "postgresql";
        local = "/run/postgres";
        vfs-cache = {
          max-age = "1h";
          max-size = "16M";
          write-back = "5s";
        };
        configFile = secrets."hosts/${hostName}/rclone.toml".path;
      };
    };
  };
  
  systemd.services.rclone-postgresql = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "postgres";
      Group = "postgres";
      # Grant Runtime directory to vfs mount
      RuntimeDirectory = "postgres";
      RuntimeDirectoryMode = "0700";
      # Grant Cache directory to vfs cache
      CacheDirectory = "postgres";
      CacheDirectoryMode = "0700";
      # Grant FUSE mount capability to non-root user
      AmbientCapabilities = [ "CAP_SYS_ADMIN" ];
      CapabilityBoundingSet = [ "CAP_SYS_ADMIN" ];
    };
    environment = {
      XDG_CACHE_HOME = "/var/cache/postgres";
    };
  };
}
