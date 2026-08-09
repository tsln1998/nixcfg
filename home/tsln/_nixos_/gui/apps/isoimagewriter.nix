{ pkgs, ... }:
{
  home.packages = [
    pkgs.kdePackages.isoimagewriter
  ];
}
