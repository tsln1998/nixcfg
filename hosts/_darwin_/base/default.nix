{
  inputs,
  outputs,
  tools,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.comin.darwinModules.comin
    inputs.agenix.darwinModules.default
    inputs.catppuccin.darwinModules.catppuccin
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    outputs.darwinModules.default
  ];

  system.stateVersion = 7;
}
