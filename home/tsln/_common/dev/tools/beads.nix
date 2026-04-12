{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.additions.beads
    pkgs.dolt
  ];
}
