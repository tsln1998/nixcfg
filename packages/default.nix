pkgs: {
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codegraph = pkgs.callPackage ./codegraph/codegraph.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
