{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.unstable.beads
  ];

  programs.git = {
    ignores = [ ".beads" ];
  };
}
