{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  programs.konsole = {
    enable = true;
    defaultProfile = "Default";

    ui = {
      colorScheme = "BreezeDark";
    };

    extraConfig = {
      General = {
        ConfigVersion = 1;
      };
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
