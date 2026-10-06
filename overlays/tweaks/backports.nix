{ lib, ... }:
_: prev:
let
  versions = {
    rtk = "0.48.0";
    pixi = "0.80.0";
    beads = "1.3.0";
    herdr = "0.0.0";
    skills = "1.6.0";
    mcporter = "0.13.0";
    codegraph = "0.0.0";
    pi-coding-agent = "0.86.1";
  };
in
lib.mapAttrs (
  name: version:
  if !(prev ? ${name}) || lib.versionOlder prev.${name}.version version then
    prev.repos.unstable.${name}
  else
    prev.${name}
) versions
