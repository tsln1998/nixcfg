_: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # device = "/dev/disk/by-id/nvme-Lexar_SSD_ARES_2TB_NLB057R000744P2202";
        device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "200M";
              type = "EF00";
              content = {
                format = "vfat";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
                mountpoint = "/boot/efi";
                type = "filesystem";
              };
            };
            lvm = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          boot = {
            size = "1G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
            };
          };
          persist = {
            size = "64G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persist";
            };
          };
          nix = {
            size = "64G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          swap = {
            size = "32G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
          "mode=0755"
        ];
      };
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
        ];
      };
    };
  };
}
