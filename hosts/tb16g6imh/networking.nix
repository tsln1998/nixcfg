{ lib, ... }:
{
  networking.hostName = "tb16g6imh";
  networking.hostId = "454768f1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;

  networking.firewall.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = lib.mkForce "iwd";
}
