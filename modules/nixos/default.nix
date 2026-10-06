{ tools, ... }:
{
  imports = tools.scan ./. ++ [ ../_common_ ];

  nix = {
    settings.trusted-users = [
      "root"
      "@wheel"
    ];

    gc = {
      dates = "daily";
      persistent = true;
      randomizedDelaySec = "15min";
    };
  };

  nixpkgs.config.allowUnfreePackages = [ "canon-cups-ufr2" ];
  nixpkgs.flake.setFlakeRegistry = false;
  nixpkgs.flake.setNixPath = false;
}
