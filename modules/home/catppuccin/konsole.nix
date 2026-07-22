{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.catppuccin.konsole;
  enable = cfg.enable && config.programs.konsole.enable;
in
{

  options.catppuccin.konsole = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.catppuccin.enable;
      description = "Enable Catppuccin for Konsole";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.catppuccin-konsole;
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
    # Catppuccin Konsole Theme Package
    home.file = {
      ".local/share/konsole/catppuccin-${cfg.flavor}.colorscheme" = {
        source = "${cfg.package}/catppuccin-${cfg.flavor}.colorscheme";
      };
    };

    # Catppuccin Konsole Configuration
    programs.konsole.profiles = {
      "${config.programs.konsole.defaultProfile}" = {
        colorScheme = "catppuccin-${cfg.flavor}";
      };
    };
  };
}
