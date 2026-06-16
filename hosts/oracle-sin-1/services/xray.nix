{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/xray/config.json" = {
    file = relative "secrets/hosts/${hostName}/xray/config.json.age";
    mode = "0644";
  };

  services.xray = {
    enable = true;
    settingsFile = secrets."hosts/${hostName}/xray/config.json".path;
  };

  systemd.services.xray = {
    restartTriggers = [
      secrets."hosts/${hostName}/xray/config.json".file
    ];
  };
}
