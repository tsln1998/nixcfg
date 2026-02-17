pkgs: {
  crproxy = pkgs.callPackage ./crproxy/crproxy.nix { };
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  cliproxy = pkgs.callPackage ./cliproxy/cliproxy.nix { };
  cliproxy-bin = pkgs.callPackage ./cliproxy/cliproxy-bin.nix { };
  cliproxy-plus = pkgs.callPackage ./cliproxy/cliproxy-plus.nix { };
  cliproxy-plus-bin = pkgs.callPackage ./cliproxy/cliproxy-plus-bin.nix { };
  cliproxy-management = pkgs.callPackage ./cliproxy/cliproxy-management.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  vscode-extensions_vscode-buf = pkgs.callPackage ./vscode/vscode-buf.nix { };
  vscode-extensions_autopep8 = pkgs.callPackage ./vscode/autopep8.nix { };
}
