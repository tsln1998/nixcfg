{ tools, ... }:
{
  # 自动导入登录前显示管理器目录中的所有模块。
  imports = tools.scan ./.;
}
