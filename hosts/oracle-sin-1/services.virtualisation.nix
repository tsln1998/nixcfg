{ lib, ... }:
{
  virtualisation.oci-containers.backend = lib.mkForce "podman";

  virtualisation.podman.defaultNetwork = {
    settings = {
      dns_enabled = lib.mkForce true;
    };
  };
}
