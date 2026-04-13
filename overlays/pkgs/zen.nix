{ inputs, ... }:
final: _: {
  inherit (inputs.zen.packages.${final.stdenv.hostPlatform.system}) zen-browser;
}
