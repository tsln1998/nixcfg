{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nixpkgs.overlays = outputs.overlays;
  nixpkgs.config.allowUnfree = true;
}
