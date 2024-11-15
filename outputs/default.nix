{ nixpkgs, nixpkgs-unstable, ... }@inputs:
let
  inherit (nixpkgs) lib;

  mylib = import ../lib { inherit lib; };

  args = {
    inherit lib mylib inputs;

    withSpecialArgs = system: {
      inherit mylib inputs;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

        overlays = import ../overlays inputs;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };

  nixosSystems = {
    x86_64-linux = import ./x86_64-linux (args // { system = "x86_64-linux"; });
  };

  nixosSystemValues = builtins.attrValues nixosSystems;
in
{
  nixosConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.nixosConfigurations or { }) nixosSystemValues
  );

  packages = lib.attrsets.mergeAttrsList (
    map (it: it.packages or { }) nixosSystemValues
  );
}
