{
  config,
  ...
}:
let
  # Import age secrets and hostname
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
  inherit (config.virtualisation.oci-containers) backend;

  # Select database name
  db = "app-cpa";
in
{
  # CLIProxy service configuration
  virtualisation.oci-containers.containers.cpa = {
    image = "eceasy/cli-proxy-api:v6.9.24";

    environment = {
      PGSTORE_DSN = "postgresql://${db}@127.0.0.1:${toString config.services.postgresql.settings.port}/${db}";
    };

    extraOptions = [
      "--network=host"
    ];

    environmentFiles = [
      secrets."hosts/${hostName}/cpa.env".path
    ];
  };

  systemd.services."${backend}-hub" = {
    restartTriggers = [
      secrets."hosts/${hostName}/cpa.env".file
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
