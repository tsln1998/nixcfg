{ tools, ... }:
{
  # 自动导入各个登录后桌面会话管理器；当前为 Quartz/Aqua。
  imports = tools.scan ./.;
}
