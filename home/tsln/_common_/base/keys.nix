{
  config,
  tools,
  lib,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
in
{
  # Secrets
  age.secrets."users/${username}/id_ed25519" = {
    file = relative "secrets/users/${username}/id_ed25519.age";
    path = "${homeDirectory}/.ssh/id_ed25519";
    mode = "600";
    symlink = false;
  };

  age.secrets."users/${username}/id_ed25519.pub" = {
    file = relative "secrets/users/${username}/id_ed25519.pub.age";
    path = "${homeDirectory}/.ssh/id_ed25519.pub";
    mode = "644";
    symlink = false;
  };
}
