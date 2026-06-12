{ pkgs, ... }:
{
  home.packages = [
    pkgs.usbutils
    pkgs.pciutils
    pkgs.lm_sensors
    pkgs.smartmontools

    pkgs.nvd
  ];
}
