{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) enable flavor;
in
{
  config = lib.mkIf (enable && config.programs.noctalia-shell.enable) {
    # Catppuccin Noctalia Configuration
    home.file.".cache/noctalia/wallpapers.json" = 
      let
        artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${flavor}";
        wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${flavor}.png";
      in{
      text = builtins.toJSON {
        defaultWallpaper = wallpaper;
      };
    };
  };
}
