{
  system.defaults = {
    NSGlobalDomain = {
      # 根据日出日落在浅色与深色外观之间自动切换。
      AppleInterfaceStyleSwitchesAutomatically = true;
    };

    # macOS 26 已持久化、但 nix-darwin 尚未提供专用 option 的设置。
    CustomUserPreferences = {
      NSGlobalDomain = {
        # 使用蓝色作为图标与小组件的着色颜色。
        AppleIconAppearanceTintColor = "Blue";
        # 保留当前采集到的 Liquid Glass 扩散级别 0。
        NSGlassDiffusionSetting = 0;
      };
    };
  };
}
