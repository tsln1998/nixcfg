{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pack
  ];
}
