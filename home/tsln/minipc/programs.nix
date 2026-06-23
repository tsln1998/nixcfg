{ pkgs, ... }:
{
  home.packages = [
    pkgs.usbutils
    pkgs.pciutils
    pkgs.jinja2-cli
    pkgs.lm_sensors
    pkgs.btrfs-progs
    pkgs.smartmontools
  ];
}
