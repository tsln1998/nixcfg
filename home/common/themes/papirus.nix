{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.programs.plasma.enable {
  home.packages = [
    pkgs.papirus-icon-theme
  ];

  programs.plasma = {
    workspace = {
      iconTheme = "Papirus-Light";
    };
  };
}
