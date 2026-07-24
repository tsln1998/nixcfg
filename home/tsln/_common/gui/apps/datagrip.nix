{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.unstable-2511.jetbrains.datagrip
  ];
}
