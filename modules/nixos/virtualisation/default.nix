{ lib, tools, ... }:
{
  imports = tools.scan ./.;

  virtualisation.oci-containers.backend = lib.mkForce "podman";
}
