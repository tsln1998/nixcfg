{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    cmake
  ];

  home.sessionVariables = {
    CC = "clang";
    CXX = "clang";
  };
}
