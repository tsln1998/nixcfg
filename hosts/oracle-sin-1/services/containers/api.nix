{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  db = "app-api";
  name = "api";
in
{
  # Secrets
  age.secrets."hosts/${hostName}/${name}/config.env" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.env.age";
    mode = "0644";
  };

  # Sub2API service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = "ghcr.io/wei-shaw/sub2api:0.1.173";

    serviceName = name;

    environment = {
      AUTO_SETUP = "true";

      SERVER_HOST = "127.0.0.1";
      SERVER_PORT = "8319";

      DATABASE_HOST = "127.0.0.1";
      DATABASE_PORT = toString config.services.postgresql.settings.port;
      DATABASE_USER = db;
      DATABASE_DBNAME = db;
      DATABASE_SSLMODE = "disable";

      REDIS_HOST = "127.0.0.1";
      REDIS_PORT = toString config.services.redis.servers.default.port;

      TZ = "Asia/Shanghai";
    };

    environmentFiles = [
      secrets."hosts/${hostName}/${name}/config.env".path
    ];

    extraOptions = [
      "--network=host"
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
