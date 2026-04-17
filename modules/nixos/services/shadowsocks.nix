{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.services.shadowsocks-rust;
in
{
  options.services.shadowsocks-rust = {
    enable = lib.mkEnableOption "Shadowsocks Rust server";

    package = lib.mkPackageOption pkgs "shadowsocks-rust" { };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Shadowsocks configuration settings";
    };

    settingsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Shadowsocks configuration file (for sensitive data)";
    };

    environment = lib.mkOption {
      type = lib.types.nullOr lib.types.attrs;
      default = { };
      description = "Shadowsocks environment variables";
    };

    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Shadowsocks environment file (for sensitive data)";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      cwd = "/var/lib/shadowsocks-rust";
      conf = pkgs.writeText "config.json" (lib.strings.toJSON cfg.settings);
    in
    {
      systemd.services.shadowsocks-rust = {
        description = "Shadowsocks Rust server";
        documentation = [ "https://github.com/shadowsocks/shadowsocks-rust" ];
        requires = [ "network-online.target" ];
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        environment = lib.optionalAttrs (cfg.environment != null) cfg.environment;

        serviceConfig = {
          ExecStartPre = pkgs.writeScript "shadowsocks-rust-pre" (
            lib.concatStringsSep "\n" (
              [
                "#!${pkgs.runtimeShell}"
                "${lib.getExe' pkgs.coreutils "mkdir"} -p ${cwd}"
              ]
              ++ (
                if (cfg.settingsFile != null) then
                  [
                    "${lib.getExe' pkgs.coreutils "cp"} ${conf} ${cwd}/config.json"
                    "${lib.getExe' pkgs.coreutils "chmod"} 600 ${cwd}/config.json"
                    "${lib.getExe pkgs.yq-go} eval-all --inplace --output-format=json 'select(fileIndex == 0) * select(fileIndex == 1)' ${cwd}/config.json ${cfg.settingsFile}"
                  ]
                else
                  [
                    "${lib.getExe' pkgs.coreutils "ln"} -sf ${conf} ${cwd}/config.json"
                  ]
              )
            )
          );

          ExecStart = lib.concatStringsSep " " [
            (lib.getExe' cfg.package "ssserver")
            "-c"
            "${cwd}/config.json"
          ];

          DynamicUser = true;
          StateDirectory = "shadowsocks-rust";
          WorkingDirectory = cwd;
        }
        // (lib.optionalAttrs (cfg.environmentFile != null) {
          EnvironmentFile = cfg.environmentFile;
        });
      };

      environment.defaultPackages = [ cfg.package ];
    }
  );
}