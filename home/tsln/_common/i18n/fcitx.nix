{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
    };
  };

  # Plasma virutal keyboard
  programs.plasma.configFile.kwinrc = {
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

  # Wayland supported
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  i18n.inputMethod.fcitx5.addons = [
    pkgs.kdePackages.fcitx5-chinese-addons
  ];

  # 配置默认输入法
  i18n.inputMethod.fcitx5.settings.inputMethod = {
    "GroupOrder" = {
      "0" = "Default";
    };
    "Groups/0" = {
      "Name" = "Default";
      "Default Layout" = "us";
      "DefaultIM" = "shuangpin";
    };
    "Groups/0/Items/0"."Name" = "keyboard-us";
    "Groups/0/Items/1"."Name" = "shuangpin";
  };

  i18n.inputMethod.fcitx5.settings.addons = {
    pinyin.globalSection = {
      "FirstRun" = "False";
      "ShuangpinProfile" = "MS";
      "PageSize" = 9;
      "SpellEnabled" = "True";
      "SymbolsEnabled" = "True";
      "ChaiziEnabled" = "True";
      "CloudPinyinEnabled" = "True";
      "CloudPinyinIndex" = 2;
      "CloudPinyinAnimation" = "True";
    };
    cloudpinyin.globalSection = {
      "MinimumPinyinLength" = 4;
      "Backend" = "Baidu";
      "Toggle Key" = "";
    };
    punctuation.globalSection = {
      "Enabled" = "True";
      "HalfWidthPuncAfterLetterOrNumber" = "True";
      "TypePairedPunctuationsTogether" = "False";
    };
  };
}
