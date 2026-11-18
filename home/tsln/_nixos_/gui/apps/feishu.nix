{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.feishu
  ];

  programs.plasma.launchers.kickoff = lib.mkOrder 110 [ "bytedance-feishu.desktop" ];
}
