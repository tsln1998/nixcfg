{
  inputs,
  outputs,
  tools,
  pkgs,
  ...
}:
{
  # Home Manager configuration
  home-manager.backupCommand = ''
    ${pkgs.coreutils}/bin/rm -rf "$1"
  '';
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
