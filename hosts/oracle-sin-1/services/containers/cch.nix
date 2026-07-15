{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  db = "app-hub";
  name = "cch";
in
{
  # Secrets
  age.secrets."hosts/${hostName}/${name}/config.env" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.env.age";
    mode = "0644";
  };

  # Claude Code Hub service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = "ghcr.io/ding113/claude-code-hub:v0.8.10";

    serviceName = name;

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
      secrets."hosts/${hostName}/${name}/config.env".path
    ];
  };

  systemd.services.${name} = {
    restartTriggers = [
      secrets."hosts/${hostName}/${name}/config.env".file
    ];
  };

  # Database ensures
  services.postgresql = {
    ensureUsers = [
      {
        name = db;
        ensureDBOwnership = true;
      }
    ];

    ensureDatabases = [ db ];
  };
}
