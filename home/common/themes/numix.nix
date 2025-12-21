{ pkgs, ... }:
{
  home.packages = [ pkgs.numix-icon-theme-circle ];

  programs.plasma = {
    workspace = {
      iconTheme = "Numix Circle";
    };
  };
}
