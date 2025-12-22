{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.programs.plasma.enable {
  home.packages = [ pkgs.numix-icon-theme-circle ];

  programs.plasma = {
    workspace = {
      iconTheme = "Numix Circle Light";
    };
  };
}
