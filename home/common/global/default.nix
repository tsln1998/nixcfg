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
    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
    outputs.homeManagerModules.default
  ];

  home.username = lib.mkDefault "tsln";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";
}
