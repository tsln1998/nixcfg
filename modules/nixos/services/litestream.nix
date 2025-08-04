{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.litestream;
in
{
  config = lib.mkIf cfg.enable {
    systemd.services.litestream-restore = {
      description = "Restore Litestream database from backup";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = pkgs.writeShellScript "litestream-restore" ''
          for db in $(${pkgs.litestream}/bin/litestream databases | awk 'NR == 1 {next} {print $1}'); do
            ${pkgs.litestream}/bin/litestream restore -if-db-not-exists -if-replica-exists $db
          done
        '';
      };
    };

    systemd.services.litestream.after = [ "litestream-restore.service" ];
    systemd.services.litestream.requires = [ "litestream-restore.service" ];
  };
}
