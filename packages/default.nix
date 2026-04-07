pkgs: {
  caddy-l4 = pkgs.callPackage ./caddy/caddy-l4.nix { };
  catppuccin-konsole = pkgs.callPackage ./catppuccin/konsole.nix { };
}
