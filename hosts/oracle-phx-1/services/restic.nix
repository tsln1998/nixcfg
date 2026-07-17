{
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
