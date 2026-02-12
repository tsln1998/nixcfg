{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in{
  services.shadowsocks-rust = {
    enable = true;
    settingsFile = secrets."hosts/${hostName}/shadowsocks.json".path;
  };
}