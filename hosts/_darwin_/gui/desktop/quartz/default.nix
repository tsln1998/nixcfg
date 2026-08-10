{ tools, ... }:
{
  # 自动导入当前 Quartz 桌面会话目录下的所有功能模块。
  imports = tools.scan ./.;
}
