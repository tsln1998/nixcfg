{ lib, ... }:
let
  defaultFont = {
    family = "Monospace";
    pointSize = 10;
  };
  defaultFontTargets = [
    "general"
    "fixedWidth"
    "toolbar"
    "menu"
    "windowTitle"
  ];
in
{
  programs.plasma.fonts = (lib.genAttrs defaultFontTargets (_: defaultFont)) // {
    small = defaultFont // {
      pointSize = 8;
    };
  };
}
