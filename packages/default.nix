pkgs: {
  crproxy = pkgs.callPackage ./crproxy/crproxy.nix { };
  github-rrc = pkgs.callPackage ./github/rrc.nix { };
  cliproxy = pkgs.callPackage ./cliproxy/cliproxy.nix { };
  cliproxy-plus = pkgs.callPackage ./cliproxy/cliproxy-plus.nix { };
  cliproxy-management = pkgs.callPackage ./cliproxy/cliproxy-management.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  vscode-extensions_vscode-buf = pkgs.callPackage ./vscode/vscode-buf.nix { };
  vscode-extensions_autopep8 = pkgs.callPackage ./vscode/autopep8.nix { };
}
