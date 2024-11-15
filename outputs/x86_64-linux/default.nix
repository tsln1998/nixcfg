{ lib, inputs, system, withSpecialArgs }@args:
let
  hosts = inputs.haumea.lib.load {
    src = ./src;
    inputs = args // {
      specialArgs = withSpecialArgs system;
    };
  };

  hostsValues = builtins.attrValues hosts;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.nixosConfigurations or { }) hostsValues
    );
  };
in
outputs
