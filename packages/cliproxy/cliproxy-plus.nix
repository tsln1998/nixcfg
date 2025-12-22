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
  version = "6.6.40-0";
  hash = "sha256-RWbXm0iN5v3+3DKUgnX4EN/JC73YMboHPF13EvIME3o=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
