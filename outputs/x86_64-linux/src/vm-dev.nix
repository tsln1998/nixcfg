{ lib
, mylib
, inputs
, system
, specialArgs
, ...
} @args:
let
  sys = args // {
    name = "vm-dev";
    modules = [
    ];
  };
in
{
  nixosConfigurations.${sys.name} = mylib.makeNixSystem sys;
}
