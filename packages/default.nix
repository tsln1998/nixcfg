{ pkgs, ... }:
let
  apifox = pkgs.callPackage ./apifox { };
  nx-tzdb = pkgs.callPackage ./nx/tzdb { };
  nx-compat-list = pkgs.callPackage ./nx/compat-list { };
  nx-torzu = pkgs.callPackage ./nx/torzu (pkgs.kdePackages // { inherit nx-tzdb nx-compat-list; });
in
{
  inherit apifox nx-torzu;
}
