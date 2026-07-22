{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.catppuccin.wallpaper;
  artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${cfg.flavor}";
  wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${cfg.flavor}.png";
in
{

  options.catppuccin.wallpaper = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.catppuccin.enable;
      description = "Enable Catppuccin for Wallpaper";
    };

    flavor = lib.mkOption {
      type = lib.types.str;
      default = config.catppuccin.flavor;
      description = "Catppuccin flavor";
    };
  };

  config = lib.mkIf cfg.enable {
    # Catppuccin Plasma wallpaper
    programs.plasma.workspace = lib.optionalAttrs config.programs.plasma.enable {
      inherit wallpaper;
    };

    # Catppuccin Plasma Lockscreen wallpaper
    programs.plasma.kscreenlocker.appearance = lib.optionalAttrs config.programs.plasma.enable {
      inherit wallpaper;
    };
  };
}
