{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  # Kernel version > 6.9
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.9") (
    lib.mkDefault pkgs.linuxPackages_latest
  );

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.configurationLimit = 50;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.tmp.cleanOnBoot = true;

  virtualisation.hypervGuest.enable = true;
  virtualisation.oci-containers.backend = "podman";
}
