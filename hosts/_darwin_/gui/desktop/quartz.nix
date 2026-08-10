_: {
  # 物理显示器隔离桌面空间
  system.defaults.spaces = {
    spans-displays = true;
  };

  # Dock 调整
  system.defaults.dock = {
    # 展示在底部
    orientation = "bottom";
    # 仅在主屏幕显示
    appswitcher-all-displays = false;
    # 禁用自动隐藏
    autohide = false;
    # 开启放大动画
    magnification = true;
    tilesize = 38;
    largesize = 58;
    # 最小化动画
    mineffect = "genie";
    # 最近访问
    show-recents = false;
    # 应用指示器
    show-process-indicators = true;
    # 最小化到应用图标
    minimize-to-application = false;
  };
}