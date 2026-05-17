{ pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in
{
  programs.nh = {
    enable = true;
    flake = if isLinux then "/etc/nixos" else null;
  };

  programs.home-manager = {
    enable = true;
  };
}
