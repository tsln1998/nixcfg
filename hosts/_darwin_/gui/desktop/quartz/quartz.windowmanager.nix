{
  system.defaults = {
    NSGlobalDomain = {
      # 仅在应用进入全屏时自动将新窗口作为标签页打开。
      AppleWindowTabbingMode = "fullscreen";
    };

    WindowManager = {
      # 台前调度中同时显示同一应用的所有窗口。
      AppWindowGroupingBehavior = true;
      # 不自动隐藏台前调度左侧的最近使用应用条。
      AutoHide = false;
      # 始终允许点击墙纸暂时移开窗口并显示桌面。
      EnableStandardClickToShowDesktop = true;
      # 平铺窗口之间不保留边距。
      EnableTiledWindowMargins = false;
      # 允许把窗口拖到菜单栏来填满屏幕。
      EnableTopTilingByEdgeDrag = true;
      # 不启用台前调度。
      GloballyEnabled = false;
      # 使用台前调度时隐藏桌面项目；台前调度关闭时不生效。
      HideDesktop = true;
      # 使用台前调度时仍显示桌面小组件。
      StageManagerHideWidgets = false;
      # 普通桌面模式下显示桌面小组件。
      StandardHideWidgets = false;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        # 双击窗口标题栏时不最小化窗口。
        AppleMiniaturizeOnDoubleClick = false;
      };
    };
  };
}
