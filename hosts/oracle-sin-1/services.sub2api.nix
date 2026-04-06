{
  config,
  ...
}:
let
  # Import age secrets and hostname
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  # Select database name
  db = "app-sub2api";
in
{
  # CLIProxy service configuration
  virtualisation.oci-containers.containers.sub2api = {
    image = "ghcr.io/wei-shaw/sub2api:0.1.108";

    environment = {
      AUTO_SETUP = "true";

      # =======================================================================
      # Server Configuration
      # =======================================================================
      SERVER_HOST = "127.0.0.1";
      SERVER_PORT = "8319";

      # =======================================================================
      # Database Configuration (PostgreSQL)
      # =======================================================================
      DATABASE_HOST = "127.0.0.1";
      DATABASE_PORT = builtins.toString config.services.postgresql.settings.port;
      DATABASE_USER = db;
      # DATABASE_PASSWORD = "";
      DATABASE_DBNAME = db;
      DATABASE_SSLMODE = "disable";

      # =======================================================================
      # Redis Configuration
      # =======================================================================
      REDIS_HOST = "127.0.0.1";
      REDIS_PORT = builtins.toString config.services.redis.servers.default.port;

      # =======================================================================
      # Admin Account (auto-created on first run)
      # =======================================================================
      # ADMIN_EMAIL = "";
      # ADMIN_PASSWORD = "";

      # =======================================================================
      # JWT Configuration
      # =======================================================================
      # IMPORTANT: Set a fixed JWT_SECRET to prevent login sessions from being
      # invalidated after container restarts. If left empty, a random secret
      # will be generated on each startup.
      # Generate a secure secret: openssl rand -hex 32
      # JWT_SECRET = "";
      # JWT_EXPIRE_HOUR = "";

      # =======================================================================
      # TOTP (2FA) Configuration
      # =======================================================================
      # IMPORTANT: Set a fixed encryption key for TOTP secrets. If left empty,
      # a random key will be generated on each startup, causing all existing
      # TOTP configurations to become invalid (users won't be able to login
      # with 2FA).
      # Generate a secure key: openssl rand -hex 32
      # TOTP_ENCRYPTION_KEY = "";

      # =======================================================================
      # Timezone Configuration
      # This affects ALL time operations in the application:
      # - Database timestamps
      # - Usage statistics "today" boundary
      # - Subscription expiry times
      # - Log timestamps
      # Common values: Asia/Shanghai, America/New_York, Europe/London, UTC
      # =======================================================================
      TZ = "Asia/Shanghai";
    };

    extraOptions = [
      "--network=host"
    ];

    environmentFiles = [
      secrets."hosts/${hostName}/sub2api.env".path
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
