pkgs: {
  dolt = pkgs.callPackage ./dolt/dolt.nix { };
  beads = pkgs.callPackage ./beads/beads.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
