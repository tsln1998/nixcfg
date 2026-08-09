_: {
  age.identityPaths = [
    "/etc/ssh/keys/ssh_host_ed25519_key"
    "/etc/ssh/keys/ssh_host_rsa_key"
  ]
  ++ [
    "/persist/etc/ssh/keys/ssh_host_ed25519_key"
    "/persist/etc/ssh/keys/ssh_host_rsa_key"
  ]
  ++ [
    "/tmp/id_ed25519"
    "/tmp/id_rsa"
  ];
}
