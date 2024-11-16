{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    package = pkgs.unstable.docker;
  };
}
