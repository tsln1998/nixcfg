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
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
  };

  # Kernel firmware
  services.fwupd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  # Zram swap (4GB)
  zramSwap.enable = true;
  zramSwap.memoryMax = 4 * 1024 * 1024 * 1024;

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;
}
