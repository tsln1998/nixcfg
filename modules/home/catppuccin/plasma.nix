{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.strings) toSentenceCase;
  cfg = config.catppuccin.plasma;
  enable = cfg.enable && config.programs.plasma.enable;
in
{

  options.catppuccin.plasma = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.catppuccin.enable;
      description = "Enable Catppuccin for Plasma";
    };

    flavor = lib.mkOption {
      type = lib.types.str;
      default = config.catppuccin.flavor;
      description = "Catppuccin flavor";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = config.catppuccin.accent;
      description = "Catppuccin accent";
    };
  };

  config = lib.mkIf enable {
    # Catppuccin Plasma Theme Package
    home.packages = [
      (pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      })
    ];

    # Catppuccin Plasma Configuration
    programs.plasma.workspace = {
      colorScheme = "Catppuccin${toSentenceCase cfg.flavor}${toSentenceCase cfg.accent}";

      splashScreen = {
        theme = "Catppuccin-${toSentenceCase cfg.flavor}-${toSentenceCase cfg.accent}";
      };

      cursor = {
        theme = if cfg.flavor == "latte" then "Breeze_Light" else "breeze_cursors";
      };
    };
  };
}
