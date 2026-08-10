{ lib, ... }:
let
  inherit (lib.strings) concatStringsSep;

  pmsetCommands = [
    # 电池供电。
    [
      "pmset -b"
      # 仅在内存中保留睡眠状态，不写入休眠镜像。
      "hibernatemode 0"
      # 禁用长时间睡眠后进入待机模式。
      "standby 0"
      # 禁用长时间睡眠后的自动断电模式。
      "autopoweroff 0"
      # 睡眠期间不执行邮件、日历和系统维护任务。
      "powernap 0"
      # 睡眠期间不维持 TCP 网络连接，以减少耗电。
      "tcpkeepalive 0"
      # 禁用通过局域网唤醒。
      "womp 0"
      # 空闲 3 分钟后进入系统睡眠。
      "sleep 3"
      # 空闲 3 分钟后关闭显示器。
      "displaysleep 3"
      # 使用电池时自动降低显示器亮度。
      "lessbright 1"
      # 打开屏幕上盖时唤醒系统。
      "lidwake 1"
    ]

    # 交流电源。
    [
      "pmset -c"
      # 仅在内存中保留睡眠状态，不写入休眠镜像。
      "hibernatemode 0"
      # 禁用长时间睡眠后进入待机模式。
      "standby 0"
      # 禁用长时间睡眠后的自动断电模式。
      "autopoweroff 0"
      # 睡眠期间不执行邮件、日历和系统维护任务。
      "powernap 0"
      # 睡眠期间保留 TCP keepalive 网络维护。
      "tcpkeepalive 1"
      # 禁用通过局域网唤醒。
      "womp 0"
      # 空闲 10 分钟后进入系统睡眠。
      "sleep 10"
      # 空闲 5 分钟后关闭显示器。
      "displaysleep 5"
      # 打开屏幕上盖时唤醒系统。
      "lidwake 1"
    ]
  ];
in
{
  system.activationScripts.pmset = {
    # 每个供电场景用空格拼接为一条命令，再用换行分隔不同场景。
    text = concatStringsSep "\n" (map (concatStringsSep " ") pmsetCommands);
  };
}
