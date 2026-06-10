{ pkgs, ... }:
{
  home.packages = [
    pkgs.podman
    pkgs.podman-compose
  ];
}
