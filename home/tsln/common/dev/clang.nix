{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    clang
    cmake
  ];
}
