{
  inputs,
  outputs,
  tools,
  pkgs,
  ...
}:
{
  home-manager.backupFileExtension = "hm-bak";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
