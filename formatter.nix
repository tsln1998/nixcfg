_: {
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs.nixfmt.enable = true;
  programs.statix.enable = true;
  programs.statix.disabled-lints = [
    "manual_inherit_from"
  ];
}
