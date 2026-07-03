pkgs: {
  codegraph = pkgs.callPackage ./codegraph/codegraph.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
