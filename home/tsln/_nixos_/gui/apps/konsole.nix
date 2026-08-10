{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  catppuccin.konsole = {
    enable = lib.mkDefault true;
    flavor = lib.mkDefault "mocha";
  };

  programs.konsole = {
    enable = true;
    defaultProfile = "Default";

    ui = {
      colorScheme = "BreezeDark";
    };

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
