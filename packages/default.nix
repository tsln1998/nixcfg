pkgs: {
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  dolt = pkgs.callPackage ./dolt/dolt.nix { };
  beads = pkgs.callPackage ./beads/beads.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
  rustfs = pkgs.callPackage ./rustfs/rustfs.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
