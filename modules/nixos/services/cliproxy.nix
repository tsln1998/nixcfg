{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.services.cliproxy;
in
{
  options.services.cliproxy = {
    enable = lib.mkEnableOption "CLIProxyAPI is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";

    package = lib.mkPackageOption pkgs.additions "cliproxy" { };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8317;
      description = "CLIProxyAPI serve port";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "CLIProxyAPI configuration settings";
    };

    settingsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "CLIProxyAPI configuration file (for sensitive data)";
    };

    authentications = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "CLIProxyAPI authentications data tar files";
    };

    authenticationsFile = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
      description = "CLIProxyAPI authentications data tar files (for sensitive data)";
    };

    environment = lib.mkOption {
      type = lib.types.nullOr lib.types.attrs;
      default = { };
      description = "CLIProxyAPI environment variables";
    };

    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "CLIProxyAPI environment file (for sensitive data)";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open firewall for CLIProxyAPI";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      ### working directory
      cwd = "/var/lib/cliproxy";

      ### data directory
      data = "${cwd}/data";

      ### configuration file
      conf = pkgs.writeText "${cfg.package.pname}.yaml" (
        lib.strings.toJSON (
          lib.recursiveUpdate {
            port = cfg.port;
            auth-dir = data;
            request-retry = 3;
            remote-management = {
              allow-remote = false;
              secret-key = "";
            };
            quota-exceeded = {
              switch-project = true;
            };
            logging-to-file = true;
            usage-statistics-enabled = true;
          } cfg.settings
        )
      );

      ### authentication files
      files = (
        cfg.authenticationsFile
        ++ (lib.imap1 (
          i: v: pkgs.writeText "nix-${cfg.package.pname}-${toString i}.json" v
        ) cfg.authentications)
      );
    in
    {
      ### systemd service
      systemd.services.${cfg.package.pname} = {
        description = cfg.package.meta.description;
        documentation = [ cfg.package.meta.homepage ];
        requires = [ "network-online.target" ];
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        ### environment variables
        environment = (
          (lib.optionalAttrs (cfg.environment != null) cfg.environment)
          // {
            MANAGEMENT_STATIC_PATH = pkgs.additions.cliproxy-management.outPath;
          }
        );

        ### service configuration
        serviceConfig = {
          ExecStartPre = pkgs.writeScript "${cfg.package.pname}-pre" (
            lib.concatStringsSep "\n" (
              [
                ### shebang
                "#!${pkgs.runtimeShell}"
                ### clean up old symlinks
                "${lib.getExe' pkgs.toybox "find"} ${cwd} -type l -delete"
                ### create directories
                "${lib.getExe' pkgs.toybox "mkdir"} -p ${data}"
                "${lib.getExe' pkgs.toybox "chmod"} 700 ${data}"
              ]
              ++ (
                ### create new authentications symlinks
                map (f: "${lib.getExe' pkgs.toybox "ln"} -s '${f}' '${data}/${baseNameOf f}'") files
              )
              ++ (
                if (cfg.settingsFile != null) then
                  [
                    ### copy configuration file and merge
                    "${lib.getExe' pkgs.toybox "cp"} ${conf} ${cwd}/config.yaml"
                    "${lib.getExe' pkgs.toybox "chmod"} 600 ${cwd}/config.yaml"
                    "${lib.getExe pkgs.yq-go} eval-all --inplace 'select(fileIndex == 0) * select(fileIndex == 1)' ${cwd}/config.yaml ${cfg.settingsFile}"
                  ]
                else
                  [
                    ### create configuration file symlink
                    "${lib.getExe' pkgs.toybox "ln"} -sf ${conf} ${cwd}/config.yaml"
                  ]
              )
            )
          );

          ExecStart = "${lib.getExe cfg.package}";

          DynamicUser = true;
          StateDirectory = "cliproxy";
          WorkingDirectory = cwd;
        }
        ### environment file
        // (lib.optionalAttrs (cfg.environmentFile != null) {
          EnvironmentFile = cfg.environmentFile;
        });
      };
      ### open firewall
      networking.firewall = lib.optionalAttrs cfg.openFirewall {
        allowedTCPPorts = [ cfg.port ];
      };
      ### install package
      environment.defaultPackages = [
        cfg.package
      ];
    }
  );
}
