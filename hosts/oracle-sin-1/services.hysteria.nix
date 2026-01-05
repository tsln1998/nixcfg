{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.hysteria = {
    enable = true;
    configFile = secrets."hosts/${hostName}/hysteria.yaml".path;
  };

  networking.firewall = {
    allowedUDPPorts = [ 443 ];
  };
}
