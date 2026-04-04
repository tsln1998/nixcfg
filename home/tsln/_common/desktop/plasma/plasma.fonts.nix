{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  programs.plasma.fonts = {
    general = {
      family = lib.head defaultFonts.sansSerif;
      pointSize = 10;
    };
    fixedWidth = {
      family = lib.head defaultFonts.monospace;
      pointSize = 10;
    };
    toolbar = {
      family = lib.head defaultFonts.sansSerif;
      pointSize = 10;
    };
    menu = {
      family = lib.head defaultFonts.sansSerif;
      pointSize = 10;
    };
    small = {
      family = lib.head defaultFonts.sansSerif;
      pointSize = 8;
    };
    windowTitle = {
      family = lib.head defaultFonts.sansSerif;
      pointSize = 10;
    };
  };
}
