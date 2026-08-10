{ pkgs, tools, ... }:
{
  imports = tools.scan ./.;

  home.packages = [
    pkgs.gcc
  ];

  home.sessionVariables = {
    CC = "gcc";
    CXX = "g++";
  };
}
