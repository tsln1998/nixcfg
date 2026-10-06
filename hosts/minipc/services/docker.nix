{ pkgs, ... }: {
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      package = pkgs.docker;
    };
  };
}
