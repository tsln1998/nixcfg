{ lib
, system
, nixos-wsl
, home-manager
, withSpecialArgs
, ...
} @args:
let
  sys = args // {
    name = "vm-dev";

    specialArgs = withSpecialArgs system;

    modules = [
    ];
  };
in
{
  nixosConfigurations.${sys.name} = lib.makeNixSystem sys;
}
