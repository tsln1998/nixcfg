{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.nginx = {
    enable = true;
    config = ''
      include ${secrets."hosts/${hostName}/nginx.conf".path};
    '';
  };

  systemd.services.nginx = {
    restartTriggers = [
      secrets."hosts/${hostName}/nginx.conf".file
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };
}
