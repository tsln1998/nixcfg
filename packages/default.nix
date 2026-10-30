pkgs: {
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codex = pkgs.callPackage ./codex { };
  images = pkgs.callPackage ./images { };
}
