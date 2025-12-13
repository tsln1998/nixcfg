{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.cliproxy;

  volume = "cliproxy-data";

  paths = {
    binary = "/CLIProxyAPI/${cfg.cmd}";
    preset = "/CLIProxyAPI/config.yaml";
    volume = "/CLIProxyAPI/.data";
  };

  preset = pkgs.writeText "cliproxy.yaml" (
    lib.strings.toJSON (
      cfg.settings
      // {
        port = cfg.port;
        auth-dir = paths.volume;
        remote-management = {
          allow-remote = cfg.management;
          secret-key = cfg.secret;
        };
        usage-statistics-enabled = cfg.statistics;
      }
    )
  );
in
{
  options.services.cliproxy = {
    enable = lib.mkEnableOption "CLIProxyAPI is a proxy server that provides OpenAI/Gemini/Claude/Codex compatible API interfaces for CLI.";

    management = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable remote management interface";
    };

    statistics = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable usage statistics reporting";
    };

    image = lib.mkOption {
      type = lib.types.str;
      default = "eceasy/cli-proxy-api";
      description = "CLIProxyAPI image name";
    };

    tag = lib.mkOption {
      type = lib.types.str;
      default = "v6.6.8";
      description = "CLIProxyAPI image tag";
    };

    cmd = lib.mkOption {
      type = lib.types.str;
      default = "CLIProxyAPI";
      description = "CLIProxyAPI image command";
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "cliproxy";
      description = "CLIProxyAPI container name";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8137;
      description = "CLIProxyAPI serve port";
    };

    secret = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "CLIProxyAPI secret key for management authentication";
    };

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "CLIProxyAPI settings";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."${cfg.name}" = {
      image = "${cfg.image}:${cfg.tag}";
      ports = [
        "${builtins.toString cfg.port}:${builtins.toString cfg.port}"
      ];
      cmd = [
        paths.binary
        "-config"
        paths.preset
      ];
      volumes = [
        "${preset}:${paths.preset}"
        "${volume}:${paths.volume}"
      ];
    };

    environment.defaultPackages = [
      (pkgs.writeShellApplication {
        name = "cliproxy-usage";
        runtimeInputs = [
          pkgs.curl
          pkgs.jq
        ];
        text = ''
          #!/usr/bin/env bash
          curl \
            --request GET \
            --url http://localhost:${builtins.toString cfg.port}/v0/management/usage \
            --header 'Authorization: Bearer ${cfg.secret}' 2>/dev/null | jq .
        '';
      })
    ];
  };
}
