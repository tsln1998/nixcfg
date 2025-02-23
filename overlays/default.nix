{ inputs, ... }:
let
  inherit (inputs) nixpkgs-unstable nixpkgs-nur;
in
{
  unstable = final: _: {
    # pkgs.unstable
    unstable = import nixpkgs-unstable {
      system = final.system;
      config = final.config;
    };
  };
  nur = (
    # pkgs.nur
    nixpkgs-nur.overlays.default
  );
  additions =
    # pkgs.additions
    final: _: { additions = import ../packages final.pkgs; };
}
