{
  pkgs,
  config,
  ...
}:let inherit(config.networking) hostName;in
{
  age.identityPaths = [
    # host keys
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
    # shared host keys
    "/tmp/ssh_host_ed25519_key"
    "/tmp/ssh_host_rsa_key"
    # fallback keys
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
    # persist host keys
    "/persist/hosts/${hostName}/etc/ssh/ssh_host_ed25519_key"
    "/persist/hosts/${hostName}/etc/ssh/ssh_host_rsa_key"
    # persist fallback keys
    "/persist/id_rsa"
    "/persist/id_ed25519"
  ];

  environment.defaultPackages = [
    pkgs.agenix
  ];
}
