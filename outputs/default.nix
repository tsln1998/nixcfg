{ nixpkgs, nixpkgs-unstable, ... }@inputs:
let
  lib = (import ../lib { inherit (nixpkgs) lib; }) // nixpkgs.lib;

  args = (builtins.removeAttrs inputs [ "self" ]) // {
    inherit lib;

    withSpecialArgs = system: {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };

  nixosSystems = {
    x86_64-linux = import ./x86_64-linux (args // { system = "x86_64-linux"; });
    x86_64-wsl = import ./x86_64-wsl (args // { system = "x86_64-linux"; });
  };

  nixosSystemNames = builtins.attrNames nixosSystems;
  nixosSystemValues = builtins.attrValues nixosSystems;

  allSystemNames = nixosSystemNames;
  allSystemValues = nixosSystemValues;
in
{
  nixosConfigurations =
    lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or { }) nixosSystemValues);
}
