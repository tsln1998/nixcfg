{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
  inherit (config.virtualisation.oci-containers) backend;

  db = "app-hub";
in
{
  virtualisation.oci-containers.containers.hub = {
    image = "ghcr.io/ding113/claude-code-hub:v0.7.3";

    environment = {
      TZ = "Asia/Shanghai";

      DSN = "postgresql://${db}@127.0.0.1:${toString config.services.postgresql.settings.port}/${db}";

      REDIS_URL = "redis://127.0.0.1:${toString config.services.redis.servers.default.port}";

      ENABLE_RATE_LIMIT = "true";
      ENABLE_SMART_PROBING = "true";
      ENABLE_CIRCUIT_BREAKER_ON_NETWORK_ERRORS = "true";
    };

    extraOptions = [
      "--network=host"
    ];

    environmentFiles = [
      secrets."hosts/${hostName}/hub.env".path
    ];
  };

  systemd.services."${backend}-hub" = {
    restartTriggers = [
      secrets."hosts/${hostName}/hub.env".file
    ];
  };

  services.postgresql = {
    ensureUsers = [
      {
        name = db;
        ensureDBOwnership = true;
      }
    ];

    ensureDatabases = [ db ];
  };

  services.postgresqlBackup = {
    databases = [
      db
    ];
  };
}
