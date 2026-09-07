_: {
  boot.kernelModules = [
    "tcp_bbr"
    "sch_fq"
  ];

  boot.kernel.sysctl = {
    "fs.file-max" = "1000000";
    "net.core.default_qdisc" = "fq";
    "net.core.netdev_max_backlog" = "16384";
    "net.core.somaxconn" = "32768";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fastopen" = "3";
    "net.ipv4.tcp_mtu_probing" = "1";
    "net.ipv4.ip_local_port_range" = "1024 65535";
  };
}
