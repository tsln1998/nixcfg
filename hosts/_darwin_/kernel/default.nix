{ tools, ... }:
{
  # 自动导入当前目录下按功能拆分的 Darwin 内核与底层系统模块。
  imports = tools.scan ./.;
}
