{
  config,
  lib,
  pkgs,
  ...
}:
let
  hmConfig = config;
  cfg = hmConfig.services.dolt;

  inherit (lib) types;

  yamlFormat = pkgs.formats.yaml { };

  enabledInstances = lib.filterAttrs (_: instance: instance.enable) cfg.instances;

  mkEnvironment =
    environment:
    lib.mapAttrsToList (
      name: value:
      let
        rendered = if builtins.isBool value then if value then "true" else "false" else toString value;
      in
      "${name}=${rendered}"
    ) environment;

  mkGeneratedSettings = _: instance: {
    log_level = instance.logLevel;
    log_format = instance.logFormat;
    data_dir = instance.dataDir;
    cfg_dir = instance.cfgDir;
    behavior = {
      read_only = instance.readOnly;
      autocommit = instance.autocommit;
      dolt_transaction_commit = instance.doltTransactionCommit;
      event_scheduler = instance.eventScheduler;
    };
    listener = {
      host = instance.host;
      port = instance.port;
    };
  };

  mkSettings =
    name: instance: lib.recursiveUpdate (mkGeneratedSettings name instance) instance.settings;

  mkConfigPath = name: ".config/dolt/${name}/sql-server.yaml";

  mkService = name: instance: {
    Unit = {
      Description = "Dolt SQL server (${name})";
    };

    Service = {
      ExecStartPre = lib.concatStringsSep " " [
        (lib.getExe' pkgs.coreutils "mkdir")
        "-p"
        (lib.escapeShellArg instance.dataDir)
        (lib.escapeShellArg instance.cfgDir)
      ];
      ExecStart = lib.escapeShellArgs [
        (lib.getExe cfg.package)
        "sql-server"
        "--config"
        "%h/${mkConfigPath name}"
      ];
      WorkingDirectory = instance.dataDir;
      Restart = "on-failure";
      RestartSec = 2;
      Environment = mkEnvironment instance.environment;
    };

    Install.WantedBy = lib.optional instance.autoStart "default.target";
  };

  declaredPorts = lib.filter (port: port != null) (
    lib.mapAttrsToList (_: instance: instance.port) enabledInstances
  );

  duplicatePorts = lib.unique (
    lib.concatMap (
      port: lib.optional ((lib.count (candidate: candidate == port) declaredPorts) > 1) port
    ) declaredPorts
  );
in
{
  options.services.dolt = {
    package = lib.mkOption {
      type = types.package;
      default = pkgs.dolt;
      description = "Dolt package used to run sql-server.";
    };

    instances = lib.mkOption {
      default = { };
      description = "Dolt SQL server instances managed by Home Manager.";
      type = types.attrsOf (
        types.submodule (
          { name, config, ... }:
          {
            options = {
              enable = lib.mkOption {
                type = types.bool;
                default = true;
                description = "Whether to enable this Dolt SQL server instance.";
              };

              autoStart = lib.mkOption {
                type = types.bool;
                default = true;
                description = "Whether to start this instance from systemd user default.target.";
              };

              host = lib.mkOption {
                type = types.str;
                default = "localhost";
                description = "Listener host for this Dolt SQL server instance.";
              };

              port = lib.mkOption {
                type = types.nullOr types.port;
                default = null;
                description = "Listener port for this Dolt SQL server instance.";
              };

              dataDir = lib.mkOption {
                type = types.str;
                default = "${hmConfig.home.homeDirectory}/.local/share/dolt/${name}";
                description = "Directory containing Dolt repositories served by this instance.";
              };

              cfgDir = lib.mkOption {
                type = types.str;
                default = "${config.dataDir}/.doltcfg";
                description = "Directory containing Dolt SQL server metadata such as privileges.db.";
              };

              logLevel = lib.mkOption {
                type = types.enum [
                  "trace"
                  "debug"
                  "info"
                  "warning"
                  "error"
                  "fatal"
                ];
                default = "info";
                description = "Dolt SQL server log level.";
              };

              logFormat = lib.mkOption {
                type = types.enum [
                  "text"
                  "json"
                ];
                default = "text";
                description = "Dolt SQL server log format.";
              };

              readOnly = lib.mkOption {
                type = types.bool;
                default = false;
                description = "Whether to serve this instance in read-only mode.";
              };

              autocommit = lib.mkOption {
                type = types.bool;
                default = true;
                description = "Whether Dolt SQL server autocommit is enabled.";
              };

              doltTransactionCommit = lib.mkOption {
                type = types.bool;
                default = false;
                description = "Whether SQL transaction commits also create Dolt commits.";
              };

              eventScheduler = lib.mkOption {
                type = types.enum [
                  "ON"
                  "OFF"
                  "DISABLED"
                ];
                default = "ON";
                description = "Event scheduler mode for this Dolt SQL server instance.";
              };

              settings = lib.mkOption {
                type = types.attrs;
                default = { };
                description = "Additional YAML settings merged over the generated Dolt sql-server config.";
              };

              environment = lib.mkOption {
                type = types.attrsOf (
                  types.oneOf [
                    types.bool
                    types.int
                    types.path
                    types.str
                  ]
                );
                default = { };
                description = "Environment variables exposed to the systemd user service.";
              };

            };
          }
        )
      );
    };
  };

  config = {
    assertions =
      (lib.mapAttrsToList (name: instance: {
        assertion = instance.port != null;
        message = "services.dolt.instances.${name}.port must be set when the instance is enabled.";
      }) enabledInstances)
      ++ lib.optional (duplicatePorts != [ ]) {
        assertion = false;
        message = "services.dolt.instances uses duplicate listener ports: ${
          lib.concatMapStringsSep ", " toString duplicatePorts
        }";
      };

    home.packages = lib.optionals (enabledInstances != { }) [ cfg.package ];

    home.file = lib.mapAttrs' (
      name: instance:
      lib.nameValuePair (mkConfigPath name) {
        source = yamlFormat.generate "dolt-${name}-sql-server.yaml" (mkSettings name instance);
      }
    ) enabledInstances;

    systemd.user.services = lib.mapAttrs' (
      name: instance: lib.nameValuePair "dolt-${name}" (mkService name instance)
    ) enabledInstances;
  };
}
