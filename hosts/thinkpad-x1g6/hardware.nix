{ inputs, pkgs, ... }:
{

  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.configurationLimit = 50;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.initrd.kernelModules = [ "i915" ];
  boot.tmp.cleanOnBoot = true;

  hardware.enableAllFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    intel-vaapi-driver
  ];
}
