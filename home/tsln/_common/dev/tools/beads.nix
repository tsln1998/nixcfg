{ pkgs, ... }:
{
  home.packages = [
    pkgs.beads
  ];

  programs.git = {
    ignores = [ ".beads" ];
  };
}
