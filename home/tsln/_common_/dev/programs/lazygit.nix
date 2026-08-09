{ pkgs, ... }:
{
  programs.lazygit.enable = true;

  home.packages = [
    pkgs.gitflow
  ];
}
