{ lib
, mylib
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
  nixosConfigurations.${sys.name} = mylib.makeWslSystem sys;
}
