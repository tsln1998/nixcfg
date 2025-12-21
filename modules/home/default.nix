{
  outputs,
  tools,
  pkgs,
  lib,
  ...
}:
{
  imports = tools.scan ./.;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    persistent = true;
  };
  nix.package =  lib.mkDefault pkgs.nix;

  nixpkgs.overlays = outputs.overlays;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
