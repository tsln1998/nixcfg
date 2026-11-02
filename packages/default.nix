pkgs: {
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codex = pkgs.callPackage ./codex { };
  managed-npm = pkgs.callPackage ./managed-npm { };
  managed-registry = pkgs.callPackage ./managed-registry { };
}
