{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.beekeeper-studio
  ];

  programs.plasma.launchers.kickoff = lib.mkOrder 100 [ "beekeeper-studio.desktop" ];
}
