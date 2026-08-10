{
  # TODO(nix-darwin): 以下上游 option 在 macOS 26 写入失败：
  # - system.defaults.universalaccess.reduceMotion
  # - system.defaults.universalaccess.reduceTransparency
  #
  # 当前期望值均为 false，即保留系统动画和界面透明效果。macOS 26 将对应值
  # 保存在 com.apple.Accessibility 域的下列键中：
  # - ReduceMotionEnabled
  # - EnhancedBackgroundContrastEnabled
  #
  # 不使用 CustomUserPreferences 双写；等待上游适配 macOS 26 后再启用。
}
