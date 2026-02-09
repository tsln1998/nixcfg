{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.home) username;
in
{
  programs.openclaw = {
    documents = ./assets/openclaw;
    bundledPlugins = {
      oracle = {
        enable = true;
      };
      gogcli = {
        enable = true;
      };
      goplaces = {
        enable = true;
      };
    };
    instances = {
      default = {
        enable = true;
        package = pkgs.llm-agents.openclaw;
        configPath = config.age.secrets."users/${username}/openclaw/openclaw.json".path;
      };
    };
  };

  systemd.user.services = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    ${config.programs.openclaw.instances.default.systemd.unitName} = {
      Service = {
        Environment = [
          ''NODE_OPTIONS="--dns-result-order=ipv4first"''
        ];
      };
    };
  };
}
