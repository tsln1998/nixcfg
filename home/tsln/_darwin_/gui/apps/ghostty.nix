{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  catppuccin.ghostty = {
    enable = lib.mkDefault true;
    flavor = lib.mkDefault "mocha";
  };

  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      font-family = lib.head defaultFonts.monospace;
      font-size = 13;

      window-width = 100;
      window-height = 30;
      window-padding-x = 8;
      window-padding-y = 12;
      window-theme = "dark";

      macos-titlebar-style = "transparent";
      macos-option-as-alt = true;
      macos-titlebar-proxy-icon = "hidden";
      macos-icon = "xray";

      background-blur = true;
      background-opacity = 0.85;

      shell-integration = "detect";

      cursor-style = "bar";
      cursor-style-blink = true;

      copy-on-select = "clipboard";

      mouse-hide-while-typing = true;
    };
  };
}
