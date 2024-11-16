{ ... }:
final: _prev: {
  additions = import ../packages {
    inherit (final) system;
    pkgs = final;
  };
}
