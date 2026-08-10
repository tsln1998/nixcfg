{ lib, tools, ... }:
{
  imports = tools.scan ./.;

  catppuccin.plasma.enable = lib.mkDefault true;
  catppuccin.wallpaper.enable = lib.mkDefault true;

  programs.plasma = {
    enable = true;
  };
}
