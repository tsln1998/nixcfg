{
  # 2026-08-10 采集到的内建面板状态：
  # - 物理像素：2940 x 1912
  # - 逻辑分辨率：1470 x 956 @ 60 Hz
  # - 主显示器、未镜像、0° 旋转、自动亮度开启
  #
  # nix-darwin 当前没有声明分辨率、刷新率、亮度或 True Tone 的 option。
  # 不直接写入 com.apple.windowserver 的设备 plist，避免设备 UUID 变化后破坏显示配置。
}
