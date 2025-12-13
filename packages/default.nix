pkgs: {
  crproxy = pkgs.callPackage ./crproxy/crproxy.nix { };
  cliproxy = pkgs.callPackage ./cliproxy/cliproxy.nix { };
  cliproxy-plus = pkgs.callPackage ./cliproxy/cliproxy-plus.nix { };
  cliproxy-management = pkgs.callPackage ./cliproxy/cliproxy-management.nix { };
}
