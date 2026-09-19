{ config, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  age.identityPaths = [
    "/persist${homeDirectory}/.ssh/id_rsa"
    "/persist${homeDirectory}/.ssh/id_ed25519"
  ];
}
