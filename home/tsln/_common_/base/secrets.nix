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
  age = {
    # Keys
    identityPaths = [
      "${homeDirectory}/.ssh/id_rsa"
      "${homeDirectory}/.ssh/id_ed25519"
    ]
    ++ [
      "/tmp/id_rsa"
      "/tmp/id_ed25519"
    ];

    secretsDir = homeDirectory + "/.agenix";
    secretsMountPoint = homeDirectory + "/.agenix.d";

    # Secrets
    secrets."users/${username}/id_ed25519" = {
      file = relative "secrets/users/${username}/id_ed25519.age";
      path = "${homeDirectory}/.ssh/id_ed25519";
      mode = "600";
      symlink = false;
    };

    secrets."users/${username}/id_ed25519.pub" = {
      file = relative "secrets/users/${username}/id_ed25519.pub.age";
      path = "${homeDirectory}/.ssh/id_ed25519.pub";
      mode = "644";
      symlink = false;
    };
  };

  # Agenix
  home.packages = [
    pkgs.repos.agenix.agenix
  ];
}
