{ tools, ... }:
{
  imports = tools.scan ./. ++ [ ../_common_ ];

  nix.settings.trusted-users = [
    "root"
    "@admin"
  ];

  nixpkgs = {
    config = {
      allowUnfreePackages = [ ];
    };
    flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };
  };
}
