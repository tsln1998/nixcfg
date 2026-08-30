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
    package = lib.mkDefault pkgs.lixPackageSets.lix_2_95.lix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
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
  nixpkgs.config.allowUnfreePackages = [
    "canon-cups-ufr2"
  ];
  nixpkgs.config.permittedInsecurePackages = [ ];
  nixpkgs.flake.setFlakeRegistry = false;
  nixpkgs.flake.setNixPath = false;
}
