{ inputs, ... }: _: prev: {
  repos = (prev.repos or { }) // {
    unstable = import inputs.nixpkgs-unstable {
      inherit (prev) config;
      inherit (prev.stdenv.hostPlatform) system;
    };
  };
}
