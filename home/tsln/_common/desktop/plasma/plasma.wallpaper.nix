{ pkgs, config, ... }:
let
  inherit (config.catppuccin) flavor;
  artwork = pkgs.nixos-artwork.wallpapers."catppuccin-${flavor}";
  wallpaper = "${artwork}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-${flavor}.png";
in
{
  programs.plasma.workspace.wallpaper = wallpaper;
  programs.plasma.kscreenlocker.appearance.wallpaper = wallpaper;
}
