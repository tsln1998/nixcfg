{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.strings) toSentenceCase;
  enablePlasma = config.programs.plasma.enable;
  enableKonsole = config.programs.konsole.enable;
  flavor = "macchiato";
  accent = "blue";
in
{
  # Catppuccin
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault flavor;
    accent = lib.mkDefault accent;

    cache = {
      enable = true;
    };
  };

  # Catppuccin Plasma Theme Package
  home.packages = lib.optionals enablePlasma [
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
      workspace.wallpaper = wallpaper;
      workspace.colorScheme = "Catppuccin${toSentenceCase flavor}${toSentenceCase accent}";
      kscreenlocker.appearance.wallpaper = wallpaper;
    };

  # Catppuccin Konsole Theme Package
  home.file = lib.optionalAttrs enableKonsole {
    ".local/share/konsole/catppuccin-${flavor}.colorscheme" = {
      source = "${pkgs.additions.catppuccin-konsole}/catppuccin-${flavor}.colorscheme";
    };
  };

  # Catppuccin Konsole Configuration
  programs.konsole.profiles = lib.optionalAttrs enableKonsole {
    "${config.programs.konsole.defaultProfile}" = {
      colorScheme = "catppuccin-${flavor}";
    };
  };
}
