{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    corepack
  ];
}
