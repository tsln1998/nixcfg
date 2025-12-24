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
  version = "6.6.50-2";
  hash = "sha256-0/XZmSvXvpBk9LxPxNcSnx2apnCoEJLgEfLv8D9Hvcc=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
