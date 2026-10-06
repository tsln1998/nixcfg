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
  home-manager = {
    useGlobalPkgs = lib.mkForce false;
    backupCommand = ''
      ${pkgs.coreutils}/bin/rm -rf "$1"
    '';
    extraSpecialArgs = {
      inherit inputs outputs overlays;
      inherit tools;
    };
  };
}
