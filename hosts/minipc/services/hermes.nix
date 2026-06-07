{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.hermes-agent = {
    enable = true;

    container = {
      enable = true;
      image = "docker.io/library/ubuntu:26.04";
    };

    configFile = secrets."hosts/${hostName}/hermes/config.yaml".path;

    environmentFiles = [
      secrets."hosts/${hostName}/hermes/env".path
    ];
  };

  systemd.services.hermes-agent = {
    restartTriggers = [
      secrets."hosts/${hostName}/hermes/env".file
      secrets."hosts/${hostName}/hermes/config.yaml".file
    ];
  };
}
