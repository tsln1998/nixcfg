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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.configurationLimit = 15;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.fontSize = 32;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Kernel tuning
  boot.kernel.sysctl = {
    # Allow performance profiling
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
    # Lower zram priority
    "vm.swappiness" = 15;
  };

  boot.extraModprobeConfig = lib.concatStringsSep "\n" [
    # Make F1~F12 act as function keys on Apple Magic Keyboard (no Fn needed)
    "options hid_apple fnmode=2"
    # Disable AVIC for KVM (unsupported on AMD Ryzen 7 8745H)
    "options kvm_amd avic=0"
  ];

  # Kernel firmware
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  # Graphics
  hardware.graphics.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Printer and Scanner
  hardware.sane.enable = true;

  # Zram swap
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  zramSwap.algorithm = "zstd";

  # TPM 2.0 support
  security.tpm2.enable = lib.mkDefault true;

  # Firmware updates
  services.fwupd.enable = true;

  # Printer and Scanner
  services.printing.enable = true;

  # Hibernate and sleep
  services.logind.settings.Login.IdleAction = "ignore";
  services.logind.settings.Login.IdleActionSec = 0;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleSuspendKey = "ignore";
  services.logind.settings.Login.HandleHibernateKey = "ignore";
  services.logind.settings.Login.KillUserProcesses = false;

  # Sleep/hibernate turned off
  systemd.sleep.settings.Sleep.AllowSuspend = "no";
  systemd.sleep.settings.Sleep.AllowHibernation = "no";
  systemd.sleep.settings.Sleep.AllowHybridSleep = "no";

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
