pkgs: {
  dolt = pkgs.callPackage ./dolt/dolt.nix { };
  beads = pkgs.callPackage ./beads/beads.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
  codegraph = pkgs.callPackage ./codegraph/codegraph.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
