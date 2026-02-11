{ pkgs, ... }:
{
  home.packages = [
    pkgs.docker-client
    pkgs.docker-buildx
    pkgs.docker-compose
  ];
}
