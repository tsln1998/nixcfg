{
  lib,
  buildGoModule,
  fetchFromGitHub,
  ...
}:
import ./cliproxy.nix {
  inherit
    lib
    buildGoModule
    fetchFromGitHub
    ;

  repo = "CLIProxyAPIPlus";
  pname = "cliproxy-plus";
  version = "6.6.29-0";
  hash = "sha256-yj7wFV7hQe2TIQnMooyJBX4n+fHFgxoxWvaoU3GuVHk=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
