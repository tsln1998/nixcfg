{ pkgs, ... }:
{
  home.packages = [
    pkgs.usbutils
    pkgs.pciutils
    pkgs.lm_sensors
    pkgs.btrfs-progs
    pkgs.smartmontools
  ];
}
