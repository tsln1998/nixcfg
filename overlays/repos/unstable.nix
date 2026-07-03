{ inputs, ... }: _: prev: {
  unstable = import inputs.unstable {
    inherit (prev) config;
    inherit (prev.stdenv.hostPlatform) system;
  };
}
