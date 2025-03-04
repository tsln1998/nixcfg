{ pkgs, ... }:
{
  home.packages = [
    pkgs.mtr
  ];

  home.shellAliases.traceroute = "mtr";
}
