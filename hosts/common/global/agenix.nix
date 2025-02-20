{
  tools,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ (tools.module "<agenix-nixos>") ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
    "/tmp/ssh_host_ed25519_key"
    "/tmp/ssh_host_rsa_key"
  ];

  environment.defaultPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
