{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    nodejs_18
  ];
}
