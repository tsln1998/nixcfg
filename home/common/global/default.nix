{
  inputs,
  outputs,
  config,
  tools,
  lib,
  ...
}:
{
  imports = (tools.scan ./.) ++ [
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.openclaw.homeManagerModules.openclaw
    outputs.homeModules.default
  ];

  home.username = lib.mkDefault "tsln";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";
}
