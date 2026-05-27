{
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Kernel modules
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
  };

  # Zram swap (4GB)
  zramSwap.enable = true;
  zramSwap.memoryMax = 4 * 1024 * 1024 * 1024;

  # Hardware clock
  time.hardwareClockInLocalTime = lib.mkForce true;

  # Redistributable firmware
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  # Hard disk standby
  services.udev.extraRules =
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in
    mkRules [
      (mkRule [
        ''ACTION=="add|change"''
        # 过滤块设备
        ''SUBSYSTEM=="block"''
        # 过滤 sdX 设备
        ''KERNEL=="sd[a-z]"''
        # 仅针对机械盘
        ''ATTR{queue/rotational}=="1"''
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 243 /dev/%k"''
      ])
    ];

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;
}
