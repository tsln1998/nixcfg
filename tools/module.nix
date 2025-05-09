{ inputs, ... }:
name:
(
  if name == "<nixos-wsl>" then
    inputs.nixos-wsl.nixosModules.default
  else if name == "<home-manager>" then
    inputs.home-manager.nixosModules.home-manager
  else if name == "<disko>" then
    inputs.disko.nixosModules.disko
  else if name == "<comin>" then
    inputs.comin.nixosModules.comin
  else if name == "<plasma-home-manager>" then
    inputs.plasma-manager.homeManagerModules.plasma-manager
  else if name == "<agenix-nixos>" then
    inputs.agenix.nixosModules.default
  else if name == "<agenix-home-manager>" then
    inputs.agenix.homeManagerModules.default
  else if name == "<catppuccin-nixos>" then
    inputs.catppuccin.nixosModules.catppuccin
  else if name == "<catppuccin-home-manager>" then
    inputs.catppuccin.homeModules.catppuccin
  else if name == "<jetbrains-plugins>" then
    inputs.jetbrains-plugins.plugins
  else
    abort
)
