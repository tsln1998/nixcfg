{
  config,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  age.identityPaths = [
    "${homeDirectory}/.ssh/id_rsa"
    "${homeDirectory}/.ssh/id_ed25519"
  ]
  ++ [
    "/persist/${homeDirectory}/.ssh/id_rsa"
    "/persist/${homeDirectory}/.ssh/id_ed25519"
  ]
  ++ [
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
  ];

  age.secretsDir = homeDirectory + "/.agenix";
  age.secretsMountPoint = homeDirectory + "/.agenix.d";
}
