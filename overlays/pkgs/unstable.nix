{ inputs, ... }:
final: _: {
  unstable = import inputs.unstable {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };
}
