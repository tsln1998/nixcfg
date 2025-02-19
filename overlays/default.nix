{ inputs, ... }:
let
  inherit (inputs) nixpkgs-unstable;
in
{
  unstable = final: _: {
    unstable = import nixpkgs-unstable {
      system = final.system;
      config = final.config;
    };
  };
}
