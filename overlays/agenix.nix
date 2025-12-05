{ inputs, ... }:
final: _: {
  agenix = inputs.agenix.packages.${final.stdenv.hostPlatform.system}.default;
}
