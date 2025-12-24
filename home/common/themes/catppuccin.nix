{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.strings) toSentenceCase;
  plasma = config.programs.plasma.enable;
  flavor = "latte";
  accent = "blue";
in
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault flavor;
    accent = lib.mkDefault accent;

    cache = {
      enable = true;
    };
  };

  # Catppuccin Plasma Theme Package
  home.packages = lib.optionals plasma [
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
}
