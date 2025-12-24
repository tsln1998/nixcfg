{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [
        pkgs.fcitx5-rime
        pkgs.fcitx5-nord
      ]
      ++ [
        pkgs.rime-cli
        pkgs.rime-data
        pkgs.rime-zhwiki
      ];

      waylandFrontend = true;
    };
  };

  # Plasma Virutal Keyboard
  programs.plasma.configFile.kwinrc = {
    Wayland = {
      "VirtualKeyboardEnabled" = true;
      "InputMethod[\$e]" = "$HOME/.nix-profile/share/applications/fcitx5-wayland-launcher.desktop";
    };
  };

  # Wayland supported
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  home.file = {
    "rime-default.custom.yaml" = {
      target = ".local/share/fcitx5/rime/default.custom.yaml";
      text = ''
        patch:
          # 配置输入模式
          schema_list:
            - schema: double_pinyin_mspy
          # 候选词 8 个
          menu/page_size: 8
          # 配置方案切换
          switcher/caption: "[方案切换]"
          switcher/hotkeys:
            - "Shift+F3"
          # 快捷键绑定
          key_binder/bindings:
            # 按 Tab/Shift+Tab 或 -/= 切换候选词
            - {accept: "Tab", send: "Page_Down", when: composing}
            - {accept: "Shift+Tab", send: "Page_Up", when: composing}
            - {accept: "minus", send: "Page_Up", when: has_menu}
            - {accept: "equal", send: "Page_Down", when: has_menu}
      '';
    };
    "rime-double_pinyin_mspy.custom.yaml" = {
      target = ".local/share/fcitx5/rime/double_pinyin_mspy.custom.yaml";
      text = ''
        patch:
          schema/name: "微软双拼"
          schema/description: "微软双拼"
          # 配置各项开关
          switches:
            - name: ascii_mode
              reset: 0
              states: [ "中文", "西文" ]
            - name: full_shape
              states: [ "半角", "全角" ]
            - name: simplification
              reset: 1
              states: [ "漢字", "汉字" ]
            - name: ascii_punct
              reset: 1
              states: [ "。，", "．，" ]
          # 不展开到全拼
          translator/preedit_format/@before 0: xlit/abcdefghijklmnopqrstuvwxyz/ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ
          translator/preedit_format/@after last: xlit/ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ/abcdefghijklmnopqrstuvwxyz
      '';
    };
  };
}
