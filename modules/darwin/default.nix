{ tools, ... }:
{
  imports = tools.scan ./. ++ [ ../_common_ ];

  nix.settings.trusted-users = [
    "root"
    "@admin"
  ];

  nixpkgs.config.allowUnfreePackages = [ ];
  nixpkgs.flake.setFlakeRegistry = false;
  nixpkgs.flake.setNixPath = false;
}
