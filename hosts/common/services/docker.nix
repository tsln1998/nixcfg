{ lib, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    oci-containers = {
      backend = lib.mkDefault "docker";
    };
  };
}
