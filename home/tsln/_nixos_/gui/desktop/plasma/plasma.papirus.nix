{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.papirus-icon-theme
  ];

  programs.plasma = {
    workspace = {
      iconTheme = if config.catppuccin.flavor == "latte" then "Papirus-Dark" else "Papirus-Dark";
    };
  };
}
