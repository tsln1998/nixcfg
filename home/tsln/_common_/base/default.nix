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

  directory = if isLinux then "/home/${config.home.username}" else "/Users/${config.home.username}";
in
{
  imports = (tools.scan ./.) ++ [
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.plasma-manager.homeModules.plasma-manager
    outputs.homeModules.default
  ];

  home = {
    username = lib.mkDefault "tsln";
    homeDirectory = lib.mkDefault directory;
    stateVersion = "26.05";
  };
}
