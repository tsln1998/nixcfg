{ inputs, ... }:
final: prev:
let
  pkgs' = inputs.agenix.overlays.default final prev;
in
{
  agenix-cli = pkgs'.agenix;
}
