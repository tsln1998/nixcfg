{ lib, ... }@inputs:
path:
if (builtins.match "^<.+>$" path) != null then
  ((import ./module.nix inputs) path)
else
  lib.path.append ../. path
