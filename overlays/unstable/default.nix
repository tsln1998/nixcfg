{ inputs, ... }:
let
  inherit (inputs) nixpkgs-unstable;
in
final: _: {
  unstable = import nixpkgs-unstable {
    inherit (final) system config;
  };
}
