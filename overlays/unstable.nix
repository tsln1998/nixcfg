{ inputs, ... }:
final: _: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };
}
