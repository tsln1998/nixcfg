{ lib, config, ... }:
let
  inherit (config.fonts.fontconfig) defaultFonts;
in
{
  # Catppuccin Mocha 配色
  catppuccin = {
    alacritty = {
      enable = lib.mkDefault true;
      flavor = lib.mkDefault "mocha";
    };
  };

  programs = {
    alacritty = {
      enable = true;

      settings = {
        # 配置文件改动后自动重载
        general = {
          live_config_reload = true;
        };

        font = {
          normal = {
            # 跟随系统等宽字体
            family = lib.head defaultFonts.monospace;
          };
          size = 11;
        };

        window = {
          # 默认窗口尺寸
          dimensions = {
            columns = 105;
            lines = 35;
          };
          padding = {
            x = 3;
            y = 3;
          };
          # 深色标题栏
          decorations_theme_variant = "Dark";
        };

        cursor = {
          style = {
            # 竖线光标并常亮
            shape = "Beam";
            blinking = "On";
          };
        };

        # 选中即复制到剪贴板
        selection = {
          save_to_clipboard = true;
        };

        # 打字时隐藏鼠标指针
        mouse = {
          hide_when_typing = true;
        };

        keyboard = {
          bindings = [
            # Ctrl+Shift+N 在同一进程内新建窗口
            {
              key = "N";
              mods = "Control | Shift";
              action = "CreateNewWindow";
            }
          ];
        };
      };
    };
  };
}
