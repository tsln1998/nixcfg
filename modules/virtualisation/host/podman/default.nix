{ config, pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    package = pkgs.unstable.podman;
    dockerCompat = !config.virtualisation.docker.enable;
    dockerSocket.enable = !config.virtualisation.docker.enable;
  };
}
