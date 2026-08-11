{ pkgs, ... }:
{
  home.packages = [
    pkgs.smartmontools
    pkgs.q
  ];
}
