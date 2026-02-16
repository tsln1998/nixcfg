{ pkgs, config, ... }:
let
  inherit (config.catppuccin) flavor;
  artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${flavor}";
  wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${flavor}.png";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        wallpaper
      ];

      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
