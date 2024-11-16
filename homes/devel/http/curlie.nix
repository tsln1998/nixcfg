{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    curl
    wget
    curlie
    httpie
  ];
}
