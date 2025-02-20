{ inputs, ... }:
name:
(
  if name == "<nixos-wsl>" then
    inputs.nixos-wsl.nixosModules.default
  else if name == "<home-manager>" then
    inputs.home-manager.nixosModules.home-manager
  else if name == "<agenix-nixos>" then
    inputs.agenix.nixosModules.default
  else if name == "<agenix-home-manager>" then
    inputs.agenix.homeManagerModules.default
  else if name == "<jetbrains-plugins>" then
    inputs.jetbrains-plugins.plugins
  else
    abort
)
