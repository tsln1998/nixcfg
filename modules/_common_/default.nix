{
  lib,
  pkgs,
  tools,
  overlays,
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
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.overlays = overlays;
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.permittedInsecurePackages = [ ];
}
