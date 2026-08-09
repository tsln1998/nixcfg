{ pkgs, tools, ... }:
{
  imports = tools.scan ./.;

  home.packages = [
    pkgs.gcc
  ];
}
