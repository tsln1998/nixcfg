{ pkgs, ... }:
{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  boot.tmp.cleanOnBoot = true;

  # Use Initrd
  boot.initrd = {
    availableKernelModules = [
      "9p"
      "9pnet_virtio"
      "ahci"
      "ata_piix"
      "sd_mod"
      "uhci_hcd"
      "virtio_blk"
      "virtio_mmio"
      "virtio_net"
      "virtio_pci"
      "virtio_scsi"
      "vmw_pvscsi"
      "xen_blkfront"
    ];
    kernelModules = [
      "virtio_balloon"
      "virtio_console"
      "virtio_rng"
      "virtio_gpu"
    ];
  };

  # Use Xanmod Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelModules = [
    "kvm-amd"
  ];

  # Use Kernel Params
  boot.kernelParams = [
    "console=ttyS0,115200n8"
    "console=tty0"
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 2048;
    }
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4d857269-af07-4828-a30c-4c14fcfdb76d";
      fsType = "ext4";
    };
    "/efi" = {
      device = "/dev/disk/by-uuid/3601-158A";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
