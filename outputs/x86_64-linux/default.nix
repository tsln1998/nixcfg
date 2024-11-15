{ lib, mylib, inputs, system, withSpecialArgs }@args:
let
  specialArgs = withSpecialArgs system;

  hosts = inputs.haumea.lib.load {
    src = ./src;
    inputs = args // {inherit specialArgs;};
  };

  hostsValues = builtins.attrValues hosts;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.nixosConfigurations or { }) hostsValues
    );
    packages = {
      ${system} = import (mylib.relativeToRoot "packages") specialArgs;
    };
  };
in
outputs
