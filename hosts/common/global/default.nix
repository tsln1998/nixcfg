{
  inputs,
  outputs,
  tools,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.disko.nixosModules.disko
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    inputs.nixos-wsl.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules.default
  ];

}
