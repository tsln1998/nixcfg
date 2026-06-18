{ utils, ... }:
let
  inherit (utils) escapeSystemdPath;

  type = "ext4";
  where = "/mnt/hdd";
  disk = "87870ad4-9afc-4e3e-9b94-0d2ab56ccb1b";
  what = "/dev/disk/by-uuid/${disk}";
in
{
  systemd.mounts = [
    rec {
      inherit type where what;
      description = "Mount mobile HDD for Samba shares";
      options = "defaults,nofail,noatime,commit=60,errors=remount-ro";

      bindsTo = [ "${escapeSystemdPath what}.device" ];
      after = [ "${escapeSystemdPath what}.device" ];
      wantedBy = [ "${escapeSystemdPath what}.device" ];
    }
  ];
}
