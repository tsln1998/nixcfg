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

  # Sysctl
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = 1;
    "kernel.kptr_restrict" = 0;
  };

  # RAM tmpfs
  boot.tmp.useTmpfs = true;

  # GPU Drivers
  hardware.intelgpu.vaapiDriver = "intel-media-driver";

  # Firmware
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Hardware Clock
  time.hardwareClockInLocalTime = lib.mkDefault true;

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;

  # VMware Guest
  virtualisation.vmware.guest.enable = lib.mkDefault true;
}
