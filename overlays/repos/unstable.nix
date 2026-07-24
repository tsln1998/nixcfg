{ inputs, ... }: _: prev: {
  repos = (prev.repos or { }) // {
    unstable = import inputs.unstable {
      inherit (prev) config;
      inherit (prev.stdenv.hostPlatform) system;
    };
  };
}
