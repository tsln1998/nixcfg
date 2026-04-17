{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.shadowsocks-rust = {
    enable = true;
    settingsFile = secrets."hosts/${hostName}/shadowsocks.json".path;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8388 ];
    allowedUDPPorts = [ 8388 ];
  };
}
