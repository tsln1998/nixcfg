{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nixpkgs.overlays = [
    outputs.overlays.unstable
    outputs.overlays.nur
    outputs.overlays.additions
  ];

  nixpkgs.config.allowUnfree = true;
}
