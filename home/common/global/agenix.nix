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
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
    "/tmp/id_rsa_${username}"
    "/tmp/id_ed25519_${username}"
    "/tmp/ssh_host_ed25519_key"
    "/tmp/ssh_host_rsa_key"
  ];

  age.secretsDir = homeDirectory + "/.agenix";
  age.secretsMountPoint = homeDirectory + "/.agenix.d";
}
