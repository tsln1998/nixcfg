{ lib
, system
, nixos-wsl
, home-manager
, withSpecialArgs
, ...
} @args:
let
  sys = args // {
    name = "wsl-dev";

    specialArgs = withSpecialArgs system;

    modules = [
    ];
  };
in
{
  nixosConfigurations.${sys.name} = lib.makeWslSystem sys;
}
