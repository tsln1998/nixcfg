{
  lib,
  utils,
  ...
}:
let
  inherit (utils) escapeSystemdPath;
  inherit (lib.strings) concatStringsSep;

  root = "@root";
  snap = "@snapshots";
  device = "/dev/disk/by-partlabel/disk-main-btrfs";
  mountpoint = "/.btrfs";
  options = [
    "subvolid=5"
    "noatime"
  ];
in
{
  # Mount the top-level Btrfs volume for subvolume maintenance and snapshots.
  fileSystems.${mountpoint} = {
    device = device;
    fsType = "btrfs";
    options = options;
  };

  # Impermanence: root is a fresh subvolume on every boot
  # systemd in stage 1 so this runs before sysroot.mount
  boot.initrd.enable = true;
  boot.initrd.systemd.services.btrfs-wipe-root = {
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
      "${escapeSystemdPath device}.device"
    ];
    after = [
      # Device node must exist first
      "${escapeSystemdPath device}.device"
      # Let a pending hibernation resume finish before touching root
      "local-fs-pre.target"
    ];

    script = lib.concatStringsSep "\n" [
      # Mount the top-level volume to reach the subvolumes
      ''
        mkdir -p ${mountpoint}
        mount -o ${concatStringsSep "," options} ${device} ${mountpoint}
        trap 'umount ${mountpoint} && rmdir ${mountpoint}' EXIT
      ''
      # Keep the previous root as a snapshot named after its mtime
      ''
        if [[ -e ${mountpoint}/${root} ]] && [[ -e ${mountpoint}/${snap} ]]; then
            timestamp=$(date --date="@$(stat -c %Y ${mountpoint}/${root})" "+%Y%m%dT%H%M%S")
            btrfs subvolume snapshot -r ${mountpoint}/${root} ${mountpoint}/${snap}/${root}.$timestamp
            btrfs subvolume delete --recursive ${mountpoint}/${root}
        fi
      ''
      # Delete snapshots older than 30 days
      ''
        if [[ -e ${mountpoint}/${snap} ]]; then
          for i in $(find ${mountpoint}/${snap}/ -maxdepth 1 -mtime +30 -name '${root}.*'); do
              btrfs subvolume delete --recursive "$i" || true
          done
        fi
      ''
      # Fresh empty root subvolume for this boot
      ''
        if [[ ! -e ${mountpoint}/${root} ]]; then
          btrfs subvolume create ${mountpoint}/${root}
        fi
      ''
    ];
  };

  # Take hourly recovery snapshots of the persistent system subvolumes.
  services.btrbk = {
    instances = {
      "local" = {
        onCalendar = "hourly";
        settings = {
          # Keep all snapshots for 7 days, plus weekly history for 4 weeks
          # and monthly history for 6 months.
          snapshot_preserve = "7d 4w 6m";
          snapshot_preserve_min = "7d";
          timestamp_format = "long";
          volume = {
            ${mountpoint} = {
              snapshot_dir = snap;
              subvolume = {
                "@nix" = { 
                  snapshot_create = "onchange";
                };
                "@boot" = { 
                  snapshot_create = "onchange";
                };
                "@persist" = { 
                  snapshot_create = "always";
                };
              };
            };
          };
        };
      };
    };
  };

  # Run a monthly scrub to verify Btrfs data and metadata checksums.
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ mountpoint ];
  };
}
