{ inputs, ... }:
final: prev:
let
  pkgs' = inputs.comin.overlays.default final prev;
in
{
  comin = pkgs'.comin;
}
