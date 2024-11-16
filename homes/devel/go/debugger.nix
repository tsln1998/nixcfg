{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [ delve ];
}
