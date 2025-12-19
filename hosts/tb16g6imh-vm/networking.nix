{ lib, ... }:
{
  networking.hostName = "tb16g6imh-vm";
  networking.hostId = "454768f1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;

  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
}
