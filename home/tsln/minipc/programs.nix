{ pkgs, ... }:
{
  home.packages = [
    pkgs.usbutils
    pkgs.pciutils
    pkgs.jinja2-cli
    pkgs.exfatprogs
    pkgs.btrfs-progs
    pkgs.android-tools
    pkgs.smartmontools
    pkgs.q
    pkgs.nali
  ];
}
