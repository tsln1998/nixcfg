{ inputs, ... }:
final: prev:
let
  pkgs' = inputs.firefox.overlays.default final prev;
in
{
  inherit (pkgs') firefox-addons;
}
