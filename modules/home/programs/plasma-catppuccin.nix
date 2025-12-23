{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) enable flavor accent;
  inherit (lib.strings) toSentenceCase;
in
{
  config = lib.mkIf (enable && config.programs.plasma.enable) {
    # Catppuccin Plasma Theme Package
    home.packages = [
      (pkgs.catppuccin-kde.override {
        flavour = [ flavor ];
        accents = [ accent ];
      })
    ];

    # Catppuccin Plasma Configuration
    programs.plasma =
      let
        artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${flavor}";
        wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${flavor}.png";
      in
      {
        workspace = {
          inherit wallpaper;
          lookAndFeel = "Catppuccin ${toSentenceCase flavor} ${toSentenceCase accent}";
        };
        kscreenlocker.appearance = {
          inherit wallpaper;
        };
      };
  };
}
