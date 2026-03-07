{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  db = "app-hub";
in
{
  virtualisation.oci-containers.containers.hub = {
    image = "ghcr.io/ding113/claude-code-hub:v0.6.2";

    environment = {
      TZ = "Asia/Shanghai";

      DSN = "postgresql://${db}@127.0.0.1:${builtins.toString config.services.postgresql.settings.port}/${db}";

      REDIS_URL = "redis://127.0.0.1:${builtins.toString config.services.redis.servers.default.port}";

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
