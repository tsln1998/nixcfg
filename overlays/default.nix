{ inputs, ... }:
let
  inherit (inputs) nixpkgs-unstable nixpkgs-nur;
in
{
  unstable = final: _: {
    unstable = import nixpkgs-unstable {
      system = final.system;
      config = final.config;
    };
  };
  nur = (
    nixpkgs-nur.overlays.default
  );
}
