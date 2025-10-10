{ pkgs, ... }:
{
  home.packages = [
    pkgs.kubectl
    pkgs.kubevpn
    pkgs.fluxcd
    pkgs.k9s
  ];
}
