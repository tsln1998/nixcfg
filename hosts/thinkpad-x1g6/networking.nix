{ lib, ... }:
{
  networking.hostName = "thinkpad-x1g6";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
}
