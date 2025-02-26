{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.home) username;
in
{
  age.secrets."users/${username}/ssh_config" = {
    file = relative "secrets/users/${username}/ssh_config.age";
    mode = "600";
  };

  age.secrets."users/${username}/id_rsa" = {
    file = relative "secrets/users/${username}/id_rsa.age";
    mode = "600";
  };

  age.secrets."users/${username}/id_rsa.pub" = {
    file = relative "secrets/users/${username}/id_rsa.pub.age";
    mode = "644";
  };
  
  age.secrets."users/${username}/id_ed25519" = {
    file = relative "secrets/users/${username}/id_ed25519.age";
    mode = "600";
  };

  age.secrets."users/${username}/id_ed25519.pub" = {
    file = relative "secrets/users/${username}/id_ed25519.pub.age";
    mode = "644";
  };
}
