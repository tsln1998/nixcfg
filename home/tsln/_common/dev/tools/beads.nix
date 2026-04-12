{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.additions.beads
  ];
}
