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

  # Hardware clock
  time.hardwareClockInLocalTime = lib.mkForce true;

  # Redistributable firmware
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # AMD microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Immutable firmware
  services.fwupd.enable = lib.mkDefault true;

  # TPM2 Module
  security.tpm2.enable = lib.mkDefault true;
}
