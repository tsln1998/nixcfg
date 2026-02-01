{ pkgs, ... }:
{
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
      # 非首次运行
      "FirstRun" = "False";
      # 双拼方案
      "ShuangpinProfile" = "MS";
      # 每页候选词
      "PageSize" = 9;
      # 显示英文候选词
      "SpellEnabled" = "True";
      # 显示符号候选词
      "SymbolsEnabled" = "True";
      # 显示拆字候选词
      "ChaiziEnabled" = "True";
      # 启用云拼音
      "CloudPinyinEnabled" = "True";
      # 云拼音候选词顺序
      "CloudPinyinIndex" = 2;
      # 加载云拼音的时候显示动画
      "CloudPinyinAnimation" = "True";
    };
    cloudpinyin.globalSection = {
      # 最小拼音长度
      "MinimumPinyinLength" = 4;
      # 使用百度后端
      "Backend" = "Baidu";
      # 禁用切换键
      "Toggle Key" = "";
    };
    punctuation.globalSection = {
      # 启用
      "Enabled" = "True";
      # 字母或者数字之后输入半角标点
      "HalfWidthPuncAfterLetterOrNumber" = "True";
      # 同时输入成对标点 (例如引号)
      "TypePairedPunctuationsTogether" = "False";
    };
  };
}
