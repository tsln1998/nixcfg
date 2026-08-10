{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    package = null;#pkgs.alacritty;
    settings = {
      font = {
        normal = {
          family = pkgs.lib.lists.head config.fonts.fontconfig.defaultFonts.monospace;
        };
        size = 13;
      };
      window = {
        padding = {
          x = 8;
          y = 12;
        };
        dimensions = {
          columns = 100;
          lines = 30;
        };
        dynamic_title = true;
        option_as_alt = "Both";
        decorations_theme_variant = "Dark";
      };

      selection = {
        save_to_clipboard = true;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Always";
        };
        unfocused_hollow = true;
      };
      mouse = {
        hide_when_typing = true;
      };
      keyboard = {
        bindings = [
          {
            mods = "Command";
            key = "T";
            action = "None";
          }
          {
            mods = "Command";
            key = "Left";
            chars = "\u001bOH";
          }
          {
            mods = "Command";
            key = "Right";
            chars = "\u001bOF";
          }
          {
            mods = "Option";
            key = "Left";
            chars = "\u001bb";
          }
          {
            mods = "Option";
            key = "Right";
            chars = "\u001bf";
          }
        ];
      };
    };
  };
}
