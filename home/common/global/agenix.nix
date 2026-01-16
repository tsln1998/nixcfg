{
  config,
  ...
}:
let
  inherit (config.home) username homeDirectory;
in
{
  age.identityPaths = [
    # user keys
    "${homeDirectory}/.ssh/id_rsa"
    "${homeDirectory}/.ssh/id_ed25519"
    # shared user keys
    "/tmp/id_rsa_${username}"
    "/tmp/id_ed25519_${username}"
    # host keys
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
    # shared host keys
    "/tmp/ssh_host_ed25519_key"
    "/tmp/ssh_host_rsa_key"
    # fallback keys
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
    # persist user keys
    "/persist/users/${username}/.ssh/id_rsa"
    "/persist/users/${username}/.ssh/id_ed25519"
    # persist fallback keys
    "/persist/id_rsa"
    "/persist/id_ed25519"
  ];

  age.secretsDir = homeDirectory + "/.agenix";
  age.secretsMountPoint = homeDirectory + "/.agenix.d";
}
