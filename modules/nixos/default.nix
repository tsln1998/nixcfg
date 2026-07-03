{
  overlays,
  tools,
  pkgs,
  lib,
  ...
}:
{
  imports = tools.scan ./.;

  nix = {
    package = lib.mkDefault pkgs.nix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
      randomizedDelaySec = "15min";
    };
  };

  nixpkgs.overlays = overlays;
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePackages = [ ];
  nixpkgs.config.permittedInsecurePackages = [ ];
  nixpkgs.flake.setFlakeRegistry = false;
  nixpkgs.flake.setNixPath = false;
}
