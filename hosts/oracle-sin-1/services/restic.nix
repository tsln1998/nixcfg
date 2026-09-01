{
  pkgs,
  tools,
  lib,
  config,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  base = {
    initialize = true;
    createWrapper = true;
    repositoryFile = secrets."hosts/${hostName}/restic/repository".path;
    passwordFile = secrets."hosts/${hostName}/restic/password".path;
    environmentFile = secrets."hosts/${hostName}/restic/env".path;
  };
in
{
  # Secrets
  age.secrets = builtins.listToAttrs (
    map
      (fn: {
        name = "hosts/${hostName}/${fn}";
        value = {
          file = relative "secrets/hosts/${hostName}/${fn}.age";
          mode = "0644";
        };
      })
      [
        "restic/repository"
        "restic/password"
        "restic/env"
      ]
  );

  # Backup for PostgreSQL
  services.restic.backups.postgresql = base // {
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
      RandomizedDelaySec = "1m";
    };

    extraBackupArgs = [
      "--host=${lib.escapeShellArg hostName}"
      "--tag=_:postgresql"
      "--stdin-filename=postgresql.sql"
    ];

    pruneOpts = [
      "--host=${lib.escapeShellArg hostName}"
      "--tag=_:postgresql"
      "--keep-hourly 72"
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];

    command =
      let
        pg_dumpall = lib.getExe' config.services.postgresql.package "pg_dumpall";
        pg_dump = lib.getExe' config.services.postgresql.package "pg_dump";
      in
      [
        "${pkgs.writeShellScript "restic-postgresql-export" ''
          ${pg_dumpall} -U postgres -gc

          for db in ${lib.escapeShellArgs config.services.postgresql.ensureDatabases} ;do
            ${pg_dump} -U postgres -d $db -F p -Cc
          done
        ''}"
      ];
  };

  # Backup for CLIProxyAPI
  services.restic.backups.cliproxyapi = base // {
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
      RandomizedDelaySec = "1m";
    };

    extraBackupArgs = [
      "--host=${lib.escapeShellArg hostName}"
      "--tag=_:cliproxyapi"
    ];

    pruneOpts = [
      "--host=${lib.escapeShellArg hostName}"
      "--tag=_:cliproxyapi"
      "--keep-hourly 72"
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];

    paths = [ "/var/lib/cliproxyapi" ];
  };
}
