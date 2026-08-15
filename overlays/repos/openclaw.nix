{ inputs, ... }:
final: prev:
let
  openclaw = inputs.nix-openclaw.overlays.default final prev;
in
{
  repos = (prev.repos or { }) // {
    inherit openclaw;
  };
}
// {
  # required by nix-openclaw
  inherit (openclaw) openclawRuntimePlugins openclawPackages;
}
