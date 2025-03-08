{ inputs, ... }:
{

  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x280
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.tmp.cleanOnBoot = true;

  hardware.enableAllFirmware = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0ea47c4c-8649-4701-bd6f-2b18b9b60146";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/83CB-CAE8";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
  
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];
}
