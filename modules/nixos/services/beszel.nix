{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.beszel-hub;
in
{
  options.services.beszel-hub = {
    enable = lib.mkEnableOption "beszel hub service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.beszel;
    };

    address = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:8090";
      description = ''
        Beszel served address
      '';
    };

    data = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/private/beszel-hub";
      description = ''
        Beszel storage path
      '';
    };

    after = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Beszel systemd service after
      '';
    };

    superuser = {
      email = lib.mkOption {
        type = lib.types.str;
        default = "admin@example.com";
        description = ''
          Beszel dashboard superuser email
        '';
      };

      passwordFile = lib.mkOption {
        type = lib.types.path;
        description = ''
          Beszel dashboard superuser password (file)
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (
    let
      exec = lib.getExe' cfg.package "beszel-hub";
    in
    {
      environment.defaultPackages = [ cfg.package ];

      systemd.services."beszel-hub" = {
        description = "Beszel hub service";
        requires = [ "network-online.target" ] ++ cfg.after;
        after = [ "network-online.target" ] ++ cfg.after;
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          LoadCredential = "password:${cfg.superuser.passwordFile}";
        };
        script = ''
          ${exec} --dir ${cfg.data} superuser upsert ${cfg.superuser.email} $(cat ''${CREDENTIALS_DIRECTORY}/password)
          ${exec} --dir ${cfg.data} serve --http ${cfg.address}
        '';
      };
    }
  );
}
