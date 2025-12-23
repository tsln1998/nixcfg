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
  version = "6.6.47-0";
  hash = "sha256-5KLa3dc+b/f/x5Xp/pk/QZ4pv8HI4lW41PL7NhazbwI=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
