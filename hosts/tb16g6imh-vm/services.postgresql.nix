{ lib, pkgs, ... }:
let
  port = 5432;
in
{
  services.postgresql = {
    enable = true;

    # enable plugins
    package = pkgs.postgresql_17.withPackages (ps: [
      ps.postgis
    ]);

    # enable TCP/IP connection
    enableTCPIP = true;
    settings = {
      port = port;
    };

    # enable remote access
    authentication = lib.concatStringsSep "\n" [
      "host all all 0.0.0.0/0 md5"
    ];

    # initial script
    initialScript = pkgs.writeTextFile {
      name = "init-sql-script";
      text = ''
        alter user postgres with password 'postgres';
      '';
    };

    # ensure users
    ensureUsers = [
      {
        name = "postgres";
        ensureClauses.superuser = true;
      }
    ];
  };

  # allow TCP/IP connection on firewall
  networking.firewall.allowedTCPPorts = [ port ];
}
