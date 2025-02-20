{
  tools,
  config,
  lib,
  ...
}:
let
  inherit (config.home) username homeDirectory;
in
{
  imports = [ (tools.module "<agenix-home-manager>") ];

  age.identityPaths = [
    "${homeDirectory}/.ssh/id_rsa"
    "${homeDirectory}/.ssh/id_ed25519"
    "/tmp/id_rsa_${username}"
    "/tmp/id_ed25519_${username}"
    "/tmp/id_rsa"
    "/tmp/id_ed25519"
  ];

  # age.secretsDir = "${homeDirectory}/.agenix/agenix";
  # age.secretsMountPoint = "${homeDirectory}/.agenix/agenix.d";

  home.activation.agenix = lib.hm.dag.entryBefore ["checkFilesChanged"] config.systemd.user.services.agenix.Service.ExecStart;
}
