{ outputs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.unstable
  ];

  nixpkgs.config.allowUnfree = true;
}
