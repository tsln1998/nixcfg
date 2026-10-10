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
      addons = [
        # 中文输入法插件（拼音/双拼）
        pkgs.kdePackages.fcitx5-chinese-addons
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
        };
        # 各插件配置，写入 conf/*.conf
        addons = {
          # 拼音/双拼
          pinyin.globalSection = {
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
          # 云拼音
          cloudpinyin.globalSection = {
            # 触发所需最短拼音
            "MinimumPinyinLength" = 4;
            # 后端
            "Backend" = "Baidu";
            # 开关快捷键：禁用（默认 Control+Alt+Shift+C）
            "Toggle Key" = "";
          };
          # 标点
          punctuation.globalSection = {
            "Enabled" = "True";
            # 字母/数字后用半角
            "HalfWidthPuncAfterLetterOrNumber" = "True";
            # 成对标点一起输入
            "TypePairedPunctuationsTogether" = "False";
          };
        };
      };
      # Wayland 前端
      waylandFrontend = true;
    };
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
