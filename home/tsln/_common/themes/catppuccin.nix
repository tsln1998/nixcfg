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
  flavor = "latte";
  accent = "blue";
  artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${flavor}";
  wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${flavor}.png";
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
  programs.plasma.kscreenlocker = lib.optionalAttrs enablePlasma {
    appearance.wallpaper = wallpaper;
  };

  programs.plasma.workspace = lib.optionalAttrs enablePlasma {
    wallpaper = wallpaper;
    colorScheme = "Catppuccin${toSentenceCase flavor}${toSentenceCase accent}";
    splashScreen.theme = "Catppuccin-${toSentenceCase flavor}-${toSentenceCase accent}";
    cursor.theme = if flavor == "latte" then "Breeze_Light" else "breeze_cursors";
  };

  # Catppuccin Konsole Theme Package
  home.file = lib.optionalAttrs enableKonsole {
    ".local/share/konsole/catppuccin-${flavor}.colorscheme" = {
      source = "${pkgs.repos.additions.catppuccin-konsole}/catppuccin-${flavor}.colorscheme";
    };
  };

  # Catppuccin Konsole Configuration
  programs.konsole.profiles = lib.optionalAttrs enableKonsole {
    "${config.programs.konsole.defaultProfile}" = {
      colorScheme = "catppuccin-${flavor}";
    };
  };
}
