{ pkgs, config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  volume = "/var/lib/n8n";
in
{
  systemd.services.n8n = {
    description = "N8N service";
    after = [
      "network.target"
      "rclone-mount-n8n.service"
    ];
    requires = [
      "rclone-mount-n8n.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];

    environment = {
      # System
      N8N_USER_FOLDER = volume;
      N8N_DIAGNOSTICS_ENABLED = "false";
      N8N_VERSION_NOTIFICATIONS_ENABLED = "false";
      N8N_SECURE_COOKIE = "false";

      # Database
      DB_TYPE = "postgresdb";
      DB_POSTGRESDB_HOST_FILE = secrets."hosts/${hostName}/n8n.db.url".path;
      DB_POSTGRESDB_PORT = "5432";
      DB_POSTGRESDB_DATABASe = "n8n";
      DB_POSTGRESDB_USER = "n8n_owner";
      DB_POSTGRESDB_PASSWORD_FILE = secrets."hosts/${hostName}/n8n.db.passwd".path;
      DB_POSTGRESDB_SCHEMA = "public";
      DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED = "false";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.unstable.n8n}/bin/n8n";
      Restart = "on-failure";
      EnvironmentFile = secrets."hosts/${hostName}/n8n.env".path;
    };
  };

  services.rclone = {
    enable = true;
    mounts.n8n = {
      configFile = secrets."hosts/${hostName}/n8n.rclone".path;
      remote = "r2";
      subpath = "fs-n8n";
      local = "${volume}/.n8n";
      vfs-cache = {
        max-age = "1h";
        max-size = "16M";
        write-back = "1m";
      };
    };
  };
}
