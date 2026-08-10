_: {
  # 关闭启动音
  system.startup.chime = false;

  # 电源管理配置
  system.activationScripts.pmset = {
    text = ''
      pmset -c \
        hibernatemode 0 \
        standby 0 \
        autopoweroff 0 \
        powernap 0 \
        tcpkeepalive 1 \
        womp 0 \
        sleep 10 \
        displaysleep 5 \
        lidwake 1
      pmset -b \
        hibernatemode 0 \
        standby 0 \
        autopoweroff 0 \
        powernap 0 \
        tcpkeepalive 0 \
        womp 0 \
        sleep 3 \
        displaysleep 3 \
        lessbright 1 \
        lidwake 1
    '';
  };
}