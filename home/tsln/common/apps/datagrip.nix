{ pkgs, ... }:
{
  home.packages = [
    pkgs.unstable.jetbrains.datagrip
  ];
}
