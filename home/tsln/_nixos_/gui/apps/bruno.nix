{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.bruno
  ];

  programs.plasma.launchers.kickoff = lib.mkOrder 90 [ "bruno.desktop" ];
}
