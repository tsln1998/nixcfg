{
  pkgs,
  config,
  tools,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
in
{
  # Keys
  age.identityPaths = [
    "${homeDirectory}/.ssh/id_rsa"
    "${homeDirectory}/.ssh/id_ed25519"
  ]
  ++ [
    "/persist${homeDirectory}/.ssh/id_rsa"
    "/persist${homeDirectory}/.ssh/id_ed25519"
  ]
  ++ [
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
  ];

  age.secretsDir = homeDirectory + "/.agenix";
  age.secretsMountPoint = homeDirectory + "/.agenix.d";

  # Agenix
  home.packages = [
    pkgs.repos.agenix.agenix
  ];

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
