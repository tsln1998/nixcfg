{ inputs, ... }:
name:
(
  if name == "<nixos-wsl>" then
    inputs.nixos-wsl.nixosModules.default
  else if name == "<home-manager>" then
    inputs.home-manager.nixosModules.home-manager
  else if name == "<jetbrains-plugins>" then
    inputs.jetbrains-plugins.plugins
  else
    abort
)
