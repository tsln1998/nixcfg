{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/ssh_host_ed25519_key" = {
    file = relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.age";
    mode = "0600";
  };
  age.secrets."hosts/${hostName}/ssh_host_ed25519_key.pub" = {
    file = relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.pub.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/xray.json" = {
    file = relative "secrets/hosts/${hostName}/xray.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/nginx.conf" = {
    file = relative "secrets/hosts/${hostName}/nginx.conf.age";
    mode = "0644";
  };
}
