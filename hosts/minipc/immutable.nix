{
  lib,
  utils,
  ...
}:
let
  inherit (utils) escapeSystemdPath;
in
{
  # Root filesystem is an impermanent subvolume: every boot starts from a
  # fresh @root, and whatever should outlive a reboot must be listed below.

  # /persist must be mounted before anything is restored from it
  # (the subvolume itself is declared in disks.nix)
  fileSystems."/persist" = {
    neededForBoot = true;
  };

  # Whitelist of paths kept between boots
  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/etc/nixos";
        mode = "0755";
      }
      {
        directory = "/etc/ssh/keys";
        mode = "0755";
      }
      {
        directory = "/etc/NetworkManager/system-connections";
        mode = "0755";
      }
      {
        directory = "/var/tmp";
        mode = "0777";
      }
      {
        directory = "/var/cache/colord";
        mode = "0755";
      }
      {
        directory = "/var/cache/cups";
        mode = "0755";
      }
      {
        directory = "/var/cache/fwupd";
        mode = "0755";
      }
      {
        directory = "/var/cache/fwupdmgr";
        mode = "0755";
      }
      {
        directory = "/var/cache/tailscale";
        mode = "0755";
      }
      {
        directory = "/var/log/journal";
        mode = "0755";
      }
      {
        directory = "/var/lib/bluetooth";
        mode = "0755";
      }
      {
        directory = "/var/lib/nixos";
        mode = "0755";
      }
      {
        directory = "/var/lib/comin";
        mode = "0755";
      }
      {
        directory = "/var/lib/cups";
        mode = "0755";
      }
      {
        directory = "/var/lib/docker";
        mode = "0755";
      }
      {
        directory = "/var/lib/fwupd";
        mode = "0755";
      }
      {
        directory = "/var/lib/tailscale";
        mode = "0755";
      }
      {
        directory = "/var/lib/AccountsService";
        mode = "0755";
      }
      {
        directory = "/var/lib/colord";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/coredump";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/rfkill";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/timers";
        mode = "0755";
      }
      {
        directory = "/var/lib/systemd/timesync";
        mode = "0755";
      }
      {
        directory = "/var/lib/NetworkManager";
        mode = "0755";
      }
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/systemd/random-seed"
      "/var/lib/sddm/state.conf"
    ];
  };

  # Impermanence: root is a fresh subvolume on every boot
  # systemd in stage 1 so this runs before sysroot.mount
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.btrfs-wipe-root =
    let
      rootPath = "/dev/disk/by-partlabel/disk-main-btrfs";
      rootVolume = "@root";
      rootDevice = "${escapeSystemdPath rootPath}.device";

      mountpoint = "/btrfs-impermanence";
      mountpointVolume = "${mountpoint}/${rootVolume}";
      mountpointSnapshots = "${mountpoint}/.snapshots/${rootVolume}";
    in
    {
      # No implicit default dependencies, only the ordering below
      unitConfig.DefaultDependencies = false;
      # Run synchronously, initrd waits for the script to exit
      serviceConfig.Type = "oneshot";
      # Started as part of initrd.target
      wantedBy = [ "initrd.target" ];
      # Must finish before the real root is mounted
      before = [ "sysroot.mount" ];

      # Hard dependency on the device unit, not just ordering
      requires = [
        rootDevice
      ];
      after = [
        # Device node must exist first
        rootDevice
        # Let a pending hibernation resume finish before touching root
        "local-fs-pre.target"
      ];

      script = lib.concatStringsSep "\n" [
        # Mount the top-level volume to reach the subvolumes
        ''
          mkdir ${mountpoint}
          mount ${rootPath} ${mountpoint}
          trap 'umount ${mountpoint}' EXIT
        ''
        # Keep the previous root as a snapshot named after its mtime
        ''
          if [[ -e ${mountpointVolume} ]]; then
              mkdir -p ${mountpointSnapshots}
              timestamp=$(date --date="@$(stat -c %Y ${mountpointVolume})" "+%Y%m%d%H%M%S")
              mv ${mountpointVolume} "${mountpointSnapshots}/$timestamp"
          fi
        ''
        # Delete snapshots older than 30 days
        ''
          for i in $(find ${mountpointSnapshots}/ -maxdepth 1 -mtime +30); do
              btrfs subvolume delete --recursive "$i"
          done
        ''
        # Fresh empty root subvolume for this boot
        ''
          btrfs subvolume create ${mountpointVolume}
        ''
      ];
    };
}
