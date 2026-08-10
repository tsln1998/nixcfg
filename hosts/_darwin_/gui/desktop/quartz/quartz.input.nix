{
  system.defaults = {
    "NSGlobalDomain" = {
      # 输入句首字母时自动大写。
      "NSAutomaticCapitalizationEnabled" = true;
      # 启用系统的自动句号替换。
      "NSAutomaticPeriodSubstitutionEnabled" = true;
      # 将 F1、F2 等按键作为标准功能键使用。
      "com.apple.keyboard.fnState" = true;
      # 轻点触控板即可完成单击。
      "com.apple.mouse.tapBehavior" = 1;
      # 启用双指点按或按压作为辅助点按。
      "com.apple.trackpad.enableSecondaryClick" = true;
      # 触控板指针跟踪速度设为 1.0。
      "com.apple.trackpad.scaling" = 1.0;
      # 启用 Force Click 与触觉反馈功能。
      "com.apple.trackpad.forceClick" = true;
      # 将文件拖到文件夹上悬停时自动展开文件夹。
      "com.apple.springing.enabled" = true;
      # 弹簧载入文件夹前等待 0.5 秒。
      "com.apple.springing.delay" = 0.5;
      # 启用“自然”滚动方向，内容随手指方向移动。
      "com.apple.swipescrolldirection" = true;
    };

    "trackpad" = {
      # 启用轻点来点按。
      Clicking = true;
      # 禁用轻点后拖移。
      Dragging = false;
      # 启用双指辅助点按。
      TrackpadRightClick = true;
      # 禁用三指拖移窗口或项目。
      TrackpadThreeFingerDrag = false;

      # 普通点按压力为中等；0、1、2 分别表示轻、中、重。
      FirstClickThreshold = 1;
      # Force Click 压力为中等；0、1、2 分别表示轻、中、重。
      SecondClickThreshold = 1;
      # 启用 Force Click 触发时的触觉段落反馈。
      ActuateDetents = true;
      # 不抑制 Force Click，即允许用力点按。
      ForceSuppressed = false;

      # 拖移结束后立即释放项目，不保持拖移锁定。
      DragLock = false;
      # 不使用左下角或右下角作为辅助点按区域。
      TrackpadCornerSecondaryClick = 0;
      # 禁用三指轻点查询与数据检测器。
      TrackpadThreeFingerTapGesture = 0;
      # 启用四指左右轻扫切换全屏应用与桌面空间。
      TrackpadFourFingerHorizSwipeGesture = 2;
      # 启用四指捏合打开启动台、张开放回桌面。
      TrackpadFourFingerPinchGesture = 2;
      # 启用四指上下轻扫进入调度中心或应用 Exposé。
      TrackpadFourFingerVertSwipeGesture = 2;
      # 启用带惯性的触控板滚动。
      TrackpadMomentumScroll = true;
      # 启用双指捏合缩放。
      TrackpadPinch = true;
      # 启用双指旋转手势。
      TrackpadRotate = true;
      # 启用三指左右轻扫切换全屏应用与桌面空间。
      TrackpadThreeFingerHorizSwipeGesture = 2;
      # 启用三指上下轻扫进入调度中心或应用 Exposé。
      TrackpadThreeFingerVertSwipeGesture = 2;
      # 启用双指轻点两下来进行智能缩放。
      TrackpadTwoFingerDoubleTapGesture = true;
      # 启用从右边缘双指轻扫打开通知中心。
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
    };

    # AppleKeyboardUIMode = 1 尚不能由上游原生 option 表达。
    "CustomUserPreferences" = {
      NSGlobalDomain = {
        # 保留当前键盘 UI 导航模式的原始值 1。
        "AppleKeyboardUIMode" = 1;
        # 系统发出警告音时不同时闪烁屏幕。
        "com.apple.sound.beep.flash" = false;
      };
    };
  };
}
