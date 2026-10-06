{
  inputs,
  overlays,
  outputs,
  tools,
  pkgs,
  lib,
  ...
}:
{
  # Home Manager configuration
  home-manager.useGlobalPkgs = lib.mkForce false;
  home-manager.backupCommand = ''
    ${pkgs.coreutils}/bin/rm -rf "$1"
  '';
  home-manager.extraSpecialArgs = {
    inherit inputs outputs overlays;
    inherit tools;
  };
}
