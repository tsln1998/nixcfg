{
  pkgs,
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  age = {
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
  };

  # Agenix
  home.packages = [
    pkgs.agenix-cli
  ];
}
