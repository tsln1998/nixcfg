{ config, lib, ... }:
{
  # 仅在上游模块启用 xray 时补充调优；否则会留下没有 ExecStart 的坏单元。
  systemd.services.xray = lib.mkIf config.services.xray.enable {
    serviceConfig = {
      RuntimeDirectory = "xray";
      RuntimeDirectoryMode = "0755";
    };
    environment = {
      XRAY_RAY_BUFFER_SIZE = "4";
    };
  };
}
