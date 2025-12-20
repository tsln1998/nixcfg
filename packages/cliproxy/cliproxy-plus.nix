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
  version = "6.6.34-0";
  hash = "sha256-zSH3HRi14OuL5iMF4AQQ+h2QXMwnBzr+9tmBR1Iei54=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
