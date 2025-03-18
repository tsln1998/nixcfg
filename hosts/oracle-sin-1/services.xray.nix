{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.xray = {
    enable = true;
    settingsFile = secrets."hosts/${hostName}/xray.json".path;
  };

  networking.firewall = {
    allowedTCPPorts = [ 443 ];
  };
}
