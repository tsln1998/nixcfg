{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  virtualisation.docker.package = pkgs.docker;
}
