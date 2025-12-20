{
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.configurationLimit = 50;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # RAM tmpfs
  boot.tmp.useTmpfs = true;

  # GPU Drivers
  hardware.intelgpu.vaapiDriver = "intel-media-driver";

  # Firmware
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Hardware Clock
  time.hardwareClockInLocalTime = true;

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;

  # VMware Guest
  virtualisation.vmware.guest.enable = lib.mkDefault true;
}
