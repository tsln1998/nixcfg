{ tools, lib, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/comin.nix"
      "hosts/common/services/bbr.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  virtualisation.oci-containers.backend = lib.mkDefault "docker";

  system.stateVersion = "25.05";
}
