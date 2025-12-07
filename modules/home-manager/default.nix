{ outputs, tools, ... }:
{
  imports = tools.scan ./.;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
  };

  nixpkgs.overlays = outputs.overlays;
  nixpkgs.config.allowUnfree = true;
}
