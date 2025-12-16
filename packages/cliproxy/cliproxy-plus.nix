{
  lib,
  buildGoModule,
  fetchFromGitHub,
  ...
}:
import ./cliproxy.nix {
  inherit lib buildGoModule fetchFromGitHub;
  repo = "CLIProxyAPIPlus";
  pname = "cliproxy-plus";
  version = "6.6.18-0";
  hash = "sha256-pdYHvk6wSjPqLUIX4SstoUZSV/skD9zIHV4eBWlBoK4=";
  vendorHash = "sha256-4h2m1NXOhTkSH5SEX13u4zGlyDLzsbjLhtP2sNtJR0s=";
}
