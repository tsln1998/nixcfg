{ inputs, ... }: _: prev: {
  repos = (prev.repos or { }) // {
    unstable-2511 = import inputs.unstable-2511 {
      system = prev.stdenv.hostPlatform.system;
      config = {
        allowUnfree = prev.config.allowUnfree;
        allowUnfreePredicate = pkg: builtins.elem (prev.lib.getName pkg) prev.config.allowUnfreePackages;
        permittedInsecurePackages = prev.config.permittedInsecurePackages;
      };
    };
  };
}
