{
  inputs,
  outputs,
  config,
  tools,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  imports = (tools.scan ./.) ++ [
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.plasma-manager.homeModules.plasma-manager
    outputs.homeModules.default
  ];

  home.username = lib.mkDefault "tsln";
  home.homeDirectory = lib.mkDefault (
    if isLinux then "/home/${config.home.username}" else "/Users/${config.home.username}"
  );
  home.stateVersion = "26.05";
}
