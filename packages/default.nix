pkgs: {
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
  vscode-extensions_vscode-buf = pkgs.callPackage ./vscode/vscode-buf.nix { };
  vscode-extensions_autopep8 = pkgs.callPackage ./vscode/autopep8.nix { };
}
