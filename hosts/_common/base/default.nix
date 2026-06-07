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
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.hermes-agent.nixosModules.default
    outputs.nixosModules.default
  ];

  system.stateVersion = "26.05";
}
