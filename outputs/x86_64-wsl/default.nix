{ lib, haumea, ... }@args:
let
  hosts = haumea.lib.load {
    src = ./src;
    inputs = args;
  };

  hostsValues = builtins.attrValues hosts;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.nixosConfigurations or { }) hostsValues
    );
  };
in
outputs
