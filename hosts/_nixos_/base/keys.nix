{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/ssh_host_ed25519_key" = {
    file = relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.age";
    path = "/etc/ssh/keys/ssh_host_ed25519_key";
    symlink = false;
    mode = "0600";
  };
  age.secrets."hosts/${hostName}/ssh_host_ed25519_key.pub" = {
    file = relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.pub.age";
    path = "/etc/ssh/keys/ssh_host_ed25519_key.pub";
    symlink = false;
    mode = "0644";
  };
}
