_: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        # imageSize = "4G";
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
            size = "4G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persist";
            };
          };
          nix = {
            size = "32G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              discardPolicy = "both";
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=128M"
          "mode=0755"
        ];
      };
    };
  };
}
