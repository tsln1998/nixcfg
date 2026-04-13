pkgs: {
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
  dolt = pkgs.callPackage ./dolt/dolt.nix { };
  beads = pkgs.callPackage ./beads/beads.nix { };
  codex = pkgs.callPackage ./codex/codex.nix { };
  zmx = pkgs.callPackage ./zmx/zmx.nix { };
}
