{
  config,
  pkgs,
  ...
}:
let
  inherit (config.networking) hostName;
in
{
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
  ]
  ++ [
    "/persist/hosts/${hostName}/etc/ssh/ssh_host_ed25519_key"
    "/persist/hosts/${hostName}/etc/ssh/ssh_host_rsa_key"
  ]
  ++ [
    "/tmp/id_rsa_${hostName}"
    "/tmp/id_ed25519_${hostName}"
  ]
  ++ [
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
  ];

  environment.defaultPackages = [
    pkgs.agenix
  ];
}
