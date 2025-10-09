{ pkgs, ... }:
{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  boot.tmp.useTmpfs = true;

  # Use Initrd
  boot.initrd = {
    availableKernelModules = [
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
      "virtio_blk"
      "virtio_scsi"
      "9p"
      "9pnet_virtio"
      "xhci_pci"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [
      "virtio_balloon"
      "virtio_console"
      "virtio_rng"
      "virtio_gpu"
    ];
  };

  # Use Kernel Params
  boot.kernelParams = [
    "console=ttyAMA0,115200n8"
    "console=tty0"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/850b03ce-145d-4a5e-98da-9770968976c9";
      fsType = "ext4";
    };
    "/efi" = {
      device = "/dev/disk/by-uuid/A2C6-6BD0";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
