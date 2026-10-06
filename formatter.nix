_: {
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt = {
      enable = true;
    };
    statix = {
      enable = true;
      disabled-lints = [
        "manual_inherit_from"
      ];
    };
    deadnix = {
      enable = true;
    };
    ruff-format = {
      enable = true;
    };
  };
}
