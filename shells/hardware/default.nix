# An environment for hardware tools
#
pkgs:
pkgs.mkShell {
  name = "hardware-devshell";
  packages = with pkgs; [
    usbutils
    pciutils
    xfsprogs
    exfatprogs
    btrfs-progs
    smartmontools
  ];
}
