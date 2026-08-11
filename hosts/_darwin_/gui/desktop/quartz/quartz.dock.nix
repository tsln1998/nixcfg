{ config, ... }:
let
  userHome = config.users.users.${config.system.primaryUser}.home;
in
{
  system.defaults.dock = {
    # 将 Dock 放在屏幕底部。
    orientation = "bottom";
    # 应用切换器仅显示在主屏幕。
    appswitcher-all-displays = false;
    # Dock 始终可见，不自动隐藏。
    autohide = false;
    # 鼠标悬停时放大 Dock 图标。
    magnification = true;
    # Dock 图标的常规尺寸为 44 点。
    tilesize = 44;
    # 悬停放大后的图标尺寸为 58 点。
    largesize = 58;
    # 窗口最小化时使用神奇效果。
    mineffect = "genie";
    # 不在 Dock 右侧显示最近使用的应用。
    show-recents = false;
    # 在正在运行的应用下方显示指示点。
    show-process-indicators = true;
    # 最小化窗口保留独立缩略图，不收进应用图标。
    minimize-to-application = false;

    # 右下角热区动作设为 1，即禁用。
    wvous-br-corner = 1;

    # 在 Dock 分隔线右侧固定目录与文件。
    persistent-others = [
      {
        folder = {
          # 在 Dock 右侧固定当前用户的下载目录。
          path = "${userHome}/Downloads";
          # 栈内项目按加入日期排序。
          arrangement = "date-added";
          # Dock 中以文件堆栈而不是普通文件夹图标显示。
          displayas = "stack";
          # 点击后使用扇形展开效果。
          showas = "fan";
        };
      }
    ];
  };
}
