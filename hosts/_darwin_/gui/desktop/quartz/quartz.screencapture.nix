{ config, ... }:
let
  userHome = config.users.users.${config.system.primaryUser}.home;
in
{
  # 当前没有自定义截图 plist；显式固定 macOS 现行默认行为。
  system.defaults.screencapture = {
    # 将截图保存到当前用户的桌面目录。
    location = "${userHome}/Desktop";
    # 使用 PNG 图片格式。
    type = "png";
    # 保留窗口截图周围的阴影。
    disable-shadow = false;
    # 截图文件名包含拍摄日期和时间。
    include-date = true;
    # 记住上一次区域截图的选区。
    save-selections = true;
    # 截图后在屏幕右下角显示浮动缩略图。
    show-thumbnail = true;
    # 截图目标为文件，而不是剪贴板或预览应用。
    target = "file";
  };
}
