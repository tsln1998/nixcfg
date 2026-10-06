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

  nixpkgs = {
    flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };
  };
}
