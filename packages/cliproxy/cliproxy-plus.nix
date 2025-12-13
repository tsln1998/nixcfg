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
  version = "6.6.8-1";
  hash = "sha256-Sx2Zxg2XhsRdRQ8AFkjgKeHqRK4hOssx/622Cq9XwjE=";
  vendorHash = "sha256-au2/wdcsW1cZNEtTUt32LtnBXME6mTHHHgd7SoSbg74=";
}
