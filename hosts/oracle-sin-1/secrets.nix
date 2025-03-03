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

  age.secrets."hosts/oracle-sin-1/beszel.passwd" = {
    file = relative "secrets/hosts/oracle-sin-1/beszel.passwd.age";
    mode = "0644";
  };

  age.secrets."hosts/oracle-sin-1/beszel.rclone" = {
    file = relative "secrets/hosts/oracle-sin-1/beszel.rclone.age";
    mode = "0644";
  };
}
