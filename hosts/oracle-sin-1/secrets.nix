{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/rclone.toml" = {
    file = relative "secrets/hosts/${hostName}/rclone.toml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/hub.env" = {
    file = relative "secrets/hosts/${hostName}/hub.env.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/cpa.env" = {
    file = relative "secrets/hosts/${hostName}/cpa.env.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/xray.json" = {
    file = relative "secrets/hosts/${hostName}/xray.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/shadowsocks.json" = {
    file = relative "secrets/hosts/${hostName}/shadowsocks.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/caddyfile" = {
    file = relative "secrets/hosts/${hostName}/caddyfile.age";
    mode = "0644";
  };
}
