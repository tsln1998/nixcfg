{
  config,
  ...
}:
let
  # Import age secrets and hostname
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  # Select database name
  db = "app-ccr";
in
{
  # CLIProxy service configuration
  virtualisation.oci-containers.containers.ccr = {
    image = "eceasy/cli-proxy-api:v6.9.7";

    environment = {
      PGSTORE_DSN = "postgresql://${db}@127.0.0.1:${builtins.toString config.services.postgresql.settings.port}/${db}";
    };

    extraOptions = [
      "--network=host"
    ];

    environmentFiles = [
      secrets."hosts/${hostName}/cpa.env".path
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
