{ lib, tools, ... }:
{
  imports = tools.scan ./.;

  programs.plasma.launchers = {
    icontasks = lib.mkMerge [
      (lib.mkOrder 30 [ "applications:org.kde.dolphin.desktop" ])
      (lib.mkOrder 60 [ "applications:org.kde.spectacle.desktop" ])
    ];

    kickoff = lib.mkMerge [
      (lib.mkOrder 30 [ "org.kde.dolphin.desktop" ])
      (lib.mkOrder 60 [ "org.kde.spectacle.desktop" ])
    ];
  };
}
