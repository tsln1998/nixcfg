{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/hysteria/config.yaml" = {
    file = relative "secrets/hosts/${hostName}/hysteria/config.yaml.age";
    mode = "0644";
  };

  services.hysteria = {
    enable = true;
    configFile = secrets."hosts/${hostName}/hysteria/config.yaml".path;
  };

  systemd.services.hysteria = {
    restartTriggers = [
      secrets."hosts/${hostName}/hysteria/config.yaml".file
    ];
  };
}
