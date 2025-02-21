{ outputs, ... }:
{
  nixpkgs.overlays = [
    outputs.overlays.unstable
    outputs.overlays.nur
  ];

  nixpkgs.config.allowUnfree = true;
}
