pkgs: {
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  vscode-extensions_buf = pkgs.callPackage ./vscode/buf.nix { };
  vscode-extensions_autopep8 = pkgs.callPackage ./vscode/autopep8.nix { };
}
