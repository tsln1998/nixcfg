{ config, tools, ... }:
let
  inherit (config.networking) hostName;
  inherit (tools) relative;
  inherit (config.age) secrets;
in
{
  age.secrets = {
    "hosts/${hostName}/ssh_host_ed25519_key".file =
      relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.age";
    "hosts/${hostName}/ssh_host_ed25519_key.pub".file =
      relative "secrets/hosts/${hostName}/ssh_host_ed25519_key.pub.age";
  };

  environment.etc = {
    "ssh/ssh_host_ed25519_key" = {
      source = secrets."hosts/${hostName}/ssh_host_ed25519_key".path;
      mode = "0600";
      user = "root";
      group = "root";
    };
    "ssh/ssh_host_ed25519_key.pub" = {
      source = secrets."hosts/${hostName}/ssh_host_ed25519_key.pub".path;
      mode = "0644";
      user = "root";
      group = "root";
    };
  };
}
