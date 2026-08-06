{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.configurationLimit = 15;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Kernel adjust
  boot.kernel.sysctl = {
    # 允许执行性能分析
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
    # 降低 Zram 优先级
    "vm.swappiness" = 15;
  };
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  # Kernel firmware
  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  services.fwupd.enable = true;
  services.fwupd.package = pkgs.fwupd;

  # Graphicals
  hardware.graphics.enable = true;
  hardware.graphics.package = pkgs.mesa;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;

  # Printer and Scanner
  services.printing.enable = true;
  hardware.sane.enable = true;
  environment.systemPackages = [
    pkgs.canon-cups-ufr2
  ];

  # Zram swap
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  zramSwap.algorithm = "zstd";

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;

  # System Directories
  systemd.tmpfiles.rules = [
    "d /mnt 0755 root root -"
  ];

  # NFS Mounts
  fileSystems = {
    "/mnt/nas/nfs/kubernetes" = {
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
    "/mnt/nas/nfs/datasets" = {
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

  # Hibernate and sleep
  services.logind.settings.Login.IdleAction = "ignore";
  services.logind.settings.Login.IdleActionSec = 0;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleSuspendKey = "ignore";
  services.logind.settings.Login.HandleHibernateKey = "ignore";
  services.logind.settings.Login.KillUserProcesses = false;

  systemd.sleep.settings.Sleep.AllowSuspend = "no";
  systemd.sleep.settings.Sleep.AllowHibernation = "no";
  systemd.sleep.settings.Sleep.AllowHybridSleep = "no";

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
