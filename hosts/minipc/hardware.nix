{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  # Use the GRUB 2 boot loader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 15;
        efiInstallAsRemovable = true;
      };
      efi = {
        efiSysMountPoint = "/boot/efi";
      };
    };

    # Kernel adjust
    kernel = {
      sysctl = {
        # 允许执行性能分析
        "kernel.perf_event_paranoid" = 1;
        "kernel.kptr_restrict" = 0;
        # 降低 Zram 优先级
        "vm.swappiness" = 15;
      };
    };

    extraModprobeConfig = lib.concatStringsSep "\n" [
      # 设置 Apple Magic Keyboard 的 F1~F12 功能键模式 (无需同时按下 Fn 即可触发)
      "options hid_apple fnmode=2"
      # 设置 KVM 禁用 AVIC (AMD Ryzen 7 8745H 不支持)
      "options kvm_amd avic=0"
    ];
  };

  hardware = {
    # Kernel firmware
    firmware = with pkgs; [
      linux-firmware
      sof-firmware
    ];

    # Graphicals
    graphics = {
      enable = true;
    };

    # Bluetooth
    bluetooth = {
      enable = true;
    };

    # Printer and Scanner
    sane = {
      enable = true;
    };
  };

  # Zram swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;

  services = {
    fwupd = {
      enable = true;
    };

    # Printer and Scanner
    printing = {
      enable = true;
    };

    # Hibernate and sleep
    logind = {
      settings = {
        Login = {
          IdleAction = "ignore";
          IdleActionSec = 0;
          HandleLidSwitch = "ignore";
          HandleLidSwitchDocked = "ignore";
          HandleLidSwitchExternalPower = "ignore";
          HandleSuspendKey = "ignore";
          HandleHibernateKey = "ignore";
          KillUserProcesses = false;
        };
      };
    };
  };

  # System Directories
  # Hibernate and sleep
  systemd = {
    tmpfiles = {
      rules = [
        "d /mnt 0755 root root -"
        "q /tmp 1777 root root 1d"
      ];
    };

    sleep = {
      settings = {
        Sleep = {
          AllowSuspend = "no";
          AllowHibernation = "no";
          AllowHybridSleep = "no";
        };
      };
    };

    targets = {
      sleep = {
        enable = false;
      };
      suspend = {
        enable = false;
      };
      hibernate = {
        enable = false;
      };
      hybrid-sleep = {
        enable = false;
      };
    };
  };
}
