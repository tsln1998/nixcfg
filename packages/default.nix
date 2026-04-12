pkgs: {
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  beads = pkgs.callPackage ./beads/beads.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
}
