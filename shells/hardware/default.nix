# An environment for hardware tools
#
pkgs:
pkgs.mkShell {
  name = "hardware-devshell";
  packages = with pkgs; [
    usbutils
    pciutils
    exfatprogs
    btrfs-progs
    smartmontools
  ];
}
