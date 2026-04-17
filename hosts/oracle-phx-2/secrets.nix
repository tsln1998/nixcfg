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
  age.secrets."hosts/${hostName}/shadowsocks.json" = {
    file = relative "secrets/hosts/${hostName}/shadowsocks.json.age";
    mode = "0644";
  };
}
