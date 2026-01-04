pkgs: {
  rrc = pkgs.callPackage ./self/rrc.nix { };
  crproxy = pkgs.callPackage ./crproxy/crproxy.nix { };
  cliproxy = pkgs.callPackage ./cliproxy/cliproxy.nix { };
  cliproxy-plus = pkgs.callPackage ./cliproxy/cliproxy-plus.nix { };
  cliproxy-management = pkgs.callPackage ./cliproxy/cliproxy-management.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  vscode-extensions = pkgs.callPackage ./vscode/extensions.nix {};
}
