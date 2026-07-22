{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  programs.konsole = {
    enable = true;
    defaultProfile = "Default";

    extraConfig = {
      MainWindow = {
        MenuBar = "Enabled";
      };
    };

    profiles = {
      Default = {
        font = {
          name = lib.head defaultFonts.monospace;
          size = 11;
        };
      };
    };
  };
}
