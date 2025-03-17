{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/caddyfile" = {
    file = relative "secrets/hosts/${hostName}/caddyfile.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/xray.json" = {
    file = relative "secrets/hosts/${hostName}/xray.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/nezha-agent.yaml" = {
    file = relative "secrets/hosts/${hostName}/nezha-agent.yaml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/alist-sync.rclone" = {
    file = relative "secrets/hosts/${hostName}/alist-sync.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/alist-webdav.rclone" = {
    file = relative "secrets/hosts/${hostName}/alist-webdav.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/radarr-sync.rclone" = {
    file = relative "secrets/hosts/${hostName}/radarr-sync.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/jackett-sync.rclone" = {
    file = relative "secrets/hosts/${hostName}/jackett-sync.rclone.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/qbittorrent-sync.rclone" = {
    file = relative "secrets/hosts/${hostName}/qbittorrent-sync.rclone.age";
    mode = "0644";
  };
}
