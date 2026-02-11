{ pkgs, ... }:
{
  home.packages = [
    pkgs.kubectl
    pkgs.kubevpn
  ];
}
