{
  inputs,
  outputs,
  tools,
  pkgs,
  ...
}:
{
  imports = [ (tools.module "<home-manager>") ];
  home-manager.backupFileExtension = "hm-bak";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit tools pkgs;
  };
}
