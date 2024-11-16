{ lib, ... }:
{
  relativeToRoot = lib.path.append ../.;

  makeNixSystem = import ./makeNixSystem.nix;
  makeWslSystem = import ./makeWslSystem.nix;
}
