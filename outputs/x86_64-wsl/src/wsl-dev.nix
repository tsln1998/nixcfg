{ lib
, inputs
, system
, specialArgs
, ...
} @args:
let
  sys = args // {
    name = "wsl-dev";
    modules = [
    ];
  };
in
{
  nixosConfigurations.${sys.name} = lib.makeWslSystem sys;
}
