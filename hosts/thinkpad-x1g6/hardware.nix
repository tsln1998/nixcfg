{ inputs, pkgs, ... }:
{

  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
  ];

  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.initrd.kernelModules = [ "i915" ];

  hardware.enableAllFirmware = true;

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-ocl
    intel-vaapi-driver
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9617bb44-9eb1-4566-9c64-6398d0404bd3";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/B9ED-D13E";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [
    #{
    #  device = "/swapfile";
    #  size = 8192;
    #}
  ];
}
