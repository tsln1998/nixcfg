{ ... }:
{

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

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

  boot.kernelParams = [
    "console=ttyAMA0,115200n8"
    "console=tty0"
  ];

  boot.tmp.useTmpfs = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6c57da79-f3f2-4fe0-8672-1ae7073215cb";
      fsType = "xfs";
    };
    "/efi" = {
      device = "/dev/disk/by-uuid/5917-F561";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
