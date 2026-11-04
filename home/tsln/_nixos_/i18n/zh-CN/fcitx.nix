{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.programs.plasma) enable;
in
{
  i18n.inputMethod = {
    enable = lib.mkDefault enable;
    type = "fcitx5";
    fcitx5 = {
      addons =
        with pkgs;
        with kdePackages;
        [
          # 中文输入法插件（拼音/双拼）
          fcitx5-chinese-addons
          # 中文模型输入
          fcitx5-phono-addons
          # 中文词库拓展
          fcitx5-pinyin-zhwiki
        ];
      settings = {
        # 全局选项
        globalOptions = {
          Hotkey = {
            # 切换嵌入式预编辑；禁用该快捷键（默认是 Control+Alt+P）
            TogglePreedit = "";
          };
        };
        # 输入法分组，写入 profile
        inputMethod = {
          # 分组顺序
          "GroupOrder" = {
            "0" = "Default";
          };
          # 默认分组
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "shuangpin";
          };
          # 组内输入法：英文键盘、双拼
          "Groups/0/Items/0"."Name" = "keyboard-us";
          "Groups/0/Items/1"."Name" = "shuangpin";
          "Groups/0/Items/2"."Name" = "phono-shuangpin";
        };
        # 各插件配置，写入 conf/*.conf
        addons = {
          # Phono 本地模型及微软双拼
          phono = {
            globalSection = {
              "ModelDirectory" = "${pkgs.fcitx5-phono-model}";
              "ShuangpinScheme" = "Microsoft";
            };
          };
          # 拼音/双拼
          pinyin = {
            globalSection = {
              # 跳过首次运行向导
              "FirstRun" = "False";
              # 双拼方案：微软
              "ShuangpinProfile" = "MS";
              # 每页候选词数
              "PageSize" = 9;
              # 英文候选
              "SpellEnabled" = "True";
              # 符号候选
              "SymbolsEnabled" = "True";
              # 拆字候选
              "ChaiziEnabled" = "True";
              # 云拼音
              "CloudPinyinEnabled" = "True";
              # 云拼音候选位置
              "CloudPinyinIndex" = 2;
              "CloudPinyinAnimation" = "True";
            };
          };
          # 云拼音
          cloudpinyin = {
            globalSection = {
              # 触发所需最短拼音
              "MinimumPinyinLength" = 2;
              # 后端
              "Backend" = "Baidu";
              # 开关快捷键：禁用（默认 Control+Alt+Shift+C）
              "Toggle Key" = "";
            };
          };
          # 标点
          punctuation = {
            globalSection = {
              "Enabled" = "True";
              # 字母/数字后用半角
              "HalfWidthPuncAfterLetterOrNumber" = "True";
              # 成对标点一起输入
              "TypePairedPunctuationsTogether" = "False";
            };
          };
        };
      };
      # Wayland 前端
      waylandFrontend = true;
    };
  };

  # 使用稳定路径，避免 D-Bus 缓存旧的 fcitx 启动命令。
  xdg.dataFile."dbus-1/services/org.fcitx.Fcitx5.service" = lib.mkIf enable {
    text = ''
      [D-BUS Service]
      Name=org.fcitx.Fcitx5
      Exec=${config.home.profileDirectory}/bin/fcitx5
    '';
  };

  # Plasma 虚拟键盘
  programs.plasma.configFile = {
    kwinrc = lib.optionalAttrs enable {
      Wayland = {
        VirtualKeyboardEnabled = {
          value = true;
        };
        InputMethod = {
          shellExpand = true;
          value = "$HOME/.nix-profile/share/applications/fcitx5-wayland-launcher.desktop";
        };
      };
    };
  };
}
