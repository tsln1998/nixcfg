{
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  cfg = config.catppuccin.wallpaper;
  enable = cfg.enable && config.catppuccin.enable && config.programs.plasma.enable;
  artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${cfg.flavor}";
  wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${cfg.flavor}.png";
in
{

  options.catppuccin = lib.optionalAttrs (options ? programs.plasma) {
    wallpaper = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.catppuccin.autoEnable;
        description = "Enable Catppuccin for Wallpaper";
      };

      flavor = lib.mkOption {
        type = lib.types.str;
        default = config.catppuccin.flavor;
        description = "Catppuccin flavor";
      };
    };
  };

  config = lib.optionalAttrs (options ? programs.plasma) (
    lib.mkIf enable {
      # Catppuccin Plasma wallpaper
      programs.plasma.workspace = {
        inherit wallpaper;
      };

      # Catppuccin Plasma Lockscreen wallpaper
      programs.plasma.kscreenlocker.appearance = {
        inherit wallpaper;
      };
    }
  );
}
