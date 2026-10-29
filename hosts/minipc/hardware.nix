{
  lib,
  pkgs,
  utils,
  inputs,
  ...
}:
let
  inherit (utils) escapeSystemdPath;
in
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

    # Impermanence: root is a fresh subvolume on every boot
    initrd = {
      enable = true;
      systemd = {
        enable = true;
        services = {
          btrfs-wipe-root =
            let
              rootPath = "/dev/disk/by-partlabel/disk-main-btrfs";
              rootVolume = "@root";
              rootDevice = "${escapeSystemdPath rootPath}.device";

              mountpoint = "/btrfs-impermanence";
              mountpointVolume = "${mountpoint}/${rootVolume}";
              mountpointSnapshots = "${mountpoint}/.snapshots/${rootVolume}";
            in
            {
              # No implicit default dependencies, only the ordering below
              unitConfig = {
                DefaultDependencies = false;
              };
              # Run synchronously, initrd waits for the script to exit
              serviceConfig = {
                Type = "oneshot";
              };
              # Started as part of initrd.target
              wantedBy = [ "initrd.target" ];
              # Must finish before the real root is mounted
              before = [ "sysroot.mount" ];

              # Hard dependency on the device unit, not just ordering
              requires = [
                rootDevice
              ];
              after = [
                # Device node must exist first
                rootDevice
                # Let a pending hibernation resume finish before touching root
                "local-fs-pre.target"
              ];

              script =lib.concatStringsSep "\n" [
                # Mount the top-level volume to reach the subvolumes
                ''
                mkdir ${mountpoint}
                mount ${rootPath} ${mountpoint}
                trap 'umount ${mountpoint}' EXIT
                ''
                # Keep the previous root as a snapshot named after its mtime
                ''
                if [[ -e ${mountpointVolume} ]]; then
                    mkdir -p ${mountpointSnapshots}
                    timestamp=$(date --date="@$(stat -c %Y ${mountpointVolume})" "+%Y%m%d%H%M%S")
                    mv ${mountpointVolume} "${mountpointSnapshots}/$timestamp"
                fi
                ''
                # Delete snapshots older than 30 days
                ''
                for i in $(find ${mountpointSnapshots}/ -maxdepth 1 -mtime +30); do
                    btrfs subvolume delete --recursive "$i"
                done
                ''
                # Fresh empty root subvolume for this boot
                ''
                btrfs subvolume create ${mountpointVolume}
              ''];
            };
        };
      };
    };

    # Kernel tuning
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

    # Graphics
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

  # TPM 2.0 support
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

  # Sleep/hibernate turned off
  systemd = {
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
