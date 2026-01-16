{
  config,
  ...
}:
let
  inherit (config.home) username homeDirectory;
in
{
  age.identityPaths = [
    "${homeDirectory}/.ssh/id_rsa"
    "${homeDirectory}/.ssh/id_ed25519"
  ]
  ++ [
    "/tmp/id_rsa_${username}"
    "/tmp/id_ed25519_${username}"
  ]
  ++ [
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
  ];

  age.secretsDir = homeDirectory + "/.agenix";
  age.secretsMountPoint = homeDirectory + "/.agenix.d";
}
