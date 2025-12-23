{ inputs, ... }:
final: _: {
  noctalia-shell = inputs.noctalia.packages.${final.stdenv.hostPlatform.system}.default;
}
