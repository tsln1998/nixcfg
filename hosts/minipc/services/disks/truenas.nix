{ ... }: {
  # NFS Mounts
  fileSystems = {
    "/mnt/truenas/kubernetes" = {
      device = "192.168.1.1:/mnt/main/nfs/kubernetes";
      fsType = "nfs";
      options = [
        # 不写入访问时间
        "noatime"
        # 远端掉线时避免进程永久死锁（卡死 IO）
        "soft"
        # 超时时间 (单位: 0.1秒, 30 表示 3 秒)
        "timeo=30"
        # 超时重试次数
        "retrans=2"
        # 开机挂载失败时不阻塞启动，无视错误
        "nofail"
        # 开机时不立即主动挂载
        "noauto"
        # 创建 automount 触发器，访问目录时自动挂载
        "x-systemd.automount"
        # (可选) 空闲 10 分钟后自动解除挂载
        "x-systemd.idle-timeout=600"
        # 尝试挂载的超时时间，快速返回不卡死
        "x-systemd.device-timeout=5s"
      ];
    };
    "/mnt/truenas/datasets" = {
      device = "192.168.1.1:/mnt/main/nfs/datasets";
      fsType = "nfs";
      options = [
        # 不写入访问时间
        "noatime"
        # 远端掉线时避免进程永久死锁（卡死 IO）
        "soft"
        # 超时时间 (单位: 0.1秒, 30 表示 3 秒)
        "timeo=30"
        # 超时重试次数
        "retrans=2"
        # 开机挂载失败时不阻塞启动，无视错误
        "nofail"
        # 开机时不立即主动挂载
        "noauto"
        # 创建 automount 触发器，访问目录时自动挂载
        "x-systemd.automount"
        # (可选) 空闲 10 分钟后自动解除挂载
        "x-systemd.idle-timeout=600"
        # 尝试挂载的超时时间，快速返回不卡死
        "x-systemd.device-timeout=5s"
      ];
    };
  };
}
