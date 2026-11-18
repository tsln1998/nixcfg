{ pkgs, lib, ... }: {
  home.packages = [
    pkgs.gitcomet
  ];

  programs.plasma.launchers.kickoff = lib.mkOrder 80 [ "gitcomet.desktop" ];
}
