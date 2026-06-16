{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/nginx/config.conf" = {
    file = relative "secrets/hosts/${hostName}/nginx/config.conf.age";
    mode = "0644";
  };

  services.nginx = {
    enable = true;
    config = ''
      include ${secrets."hosts/${hostName}/nginx/config.conf".path};
    '';
  };

  systemd.services.nginx = {
    restartTriggers = [
      secrets."hosts/${hostName}/nginx/config.conf".file
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      443
    ];
  };
}
