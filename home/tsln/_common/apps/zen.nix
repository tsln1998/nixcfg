{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.zen.zen-browser
  ];
}
