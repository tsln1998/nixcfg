{ tools, ... }:
{
  imports = tools.scan ./.;

  virtualisation.oci-containers.gc.automatic = true;
}
