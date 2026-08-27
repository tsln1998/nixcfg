_: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Lexar_SSD_ARES_2TB_NLB057R000744P2202";
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
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=1G"
          "mode=0755"
        ];
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          boot = {
            size = "2G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
            };
          };
          tmp = {
            size = "8G";
            content = {
              type = "filesystem";
              format = "ext4";
              extraArgs = [
                "-m"
                "0"
              ];
              mountpoint = "/tmp";
              mountOptions = [
                "defaults"
                "nodev"
                "nosuid"
              ];
            };
          };
          persist = {
            size = "256G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persist";
            };
          };
          nix = {
            size = "256G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
        };
      };
    };
  };
}
