{
  system.defaults = {
    NSGlobalDomain = {
      # 强制系统时间使用 24 小时制。
      AppleICUForce24HourTime = true;
    };

    menuExtraClock = {
      # 时钟中的冒号保持常亮，不按秒闪烁。
      FlashDateSeparators = false;
      # 使用数字时钟而不是模拟表盘。
      IsAnalog = false;
      # 使用 24 小时制显示时间。
      Show24Hour = true;
      # 保留当前 AM/PM 标签设置；24 小时制下通常不会显示。
      ShowAMPM = true;
      # 在菜单栏时钟旁显示星期。
      ShowDayOfWeek = true;
      # 日期仅在菜单栏空间允许时显示；0 表示“When space allows”。
      ShowDate = 0;
    };

    controlcenter = {
      # 菜单栏电池图标不显示电量百分比。
      BatteryShowPercentage = false;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        # 应用进入全屏模式后仍显示菜单栏。
        AppleMenuBarVisibleInFullscreen = true;
      };
    };

    # TODO(nix-darwin): macOS 26 的控制中心模式值 8 无法由当前两态 option
    # 无损表达。以下上游 option 已存在，但目前只能接受 bool：
    # - system.defaults.controlcenter.AirDrop
    # - system.defaults.controlcenter.Bluetooth
    # - system.defaults.controlcenter.NowPlaying
    #
    # 以下控件目前还没有专用的 nix-darwin option：
    # - KeyboardBrightness
    # - TimeMachine
    # - VoiceControl
    # - Weather
    #
    # 等待上游支持 macOS 26 的多态显示模式后再声明这些配置。
  };
}
