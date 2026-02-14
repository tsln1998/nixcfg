{ config, pkgs, ... }:
let
  # Import age secrets and hostname
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  # CLIProxy service configuration
  services.cliproxy = {
    enable = true;
    package = pkgs.repos.additions.cliproxy-plus;
    # Start after rclone mount is ready
    after = [ "rclone-cliproxy.service" ];
    settings = {
      auth-dir = "/run/cliproxy";
    };
    settingsFile = secrets."hosts/${hostName}/cliproxy.yaml".path;
  };

  # Rclone mount configuration for CLIProxy
  services.rclone = {
    enable = true;
    mounts = {
      cliproxy = {
        remote = "r2";
        subpath = "cliproxy";
        local = "/run/cliproxy";
        vfs-cache = {
          max-age = "1h";
          max-size = "16M";
          write-back = "5s";
        };
        configFile = secrets."hosts/${hostName}/rclone.toml".path;
      };
    };
  };

  # Create dedicated user and group for services
  # Override systemd services to use dedicated user/group
  users.users.cliproxy = {
    isSystemUser = true;
    group = "cliproxy";
    description = "CLIProxy service user";
  };

  users.groups.cliproxy = {
  };

  # CLIProxy systemd service overrides
  systemd.services.cliproxy = {
    serviceConfig = {
      DynamicUser = pkgs.lib.mkForce false;
      User = "cliproxy";
      Group = "cliproxy";
    };
  };

  # Rclone systemd service overrides for CLIProxy mount
  systemd.services.rclone-cliproxy = {
    serviceConfig = {
      DynamicUser = pkgs.lib.mkForce false;
      User = "cliproxy";
      Group = "cliproxy";
      # Grant Runtime directory to vfs mount
      RuntimeDirectory = "cliproxy";
      RuntimeDirectoryMode = "0700";
      # Grant Cache directory to vfs cache
      CacheDirectory = "cliproxy";
      CacheDirectoryMode = "0700";
      # Grant FUSE mount capability to non-root user
      AmbientCapabilities = [ "CAP_SYS_ADMIN" ];
      CapabilityBoundingSet = [ "CAP_SYS_ADMIN" ];
    };
    environment = {
      XDG_CACHE_HOME = "/var/cache/cliproxy";
    };
  };
}
