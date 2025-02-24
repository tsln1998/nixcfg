{ lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "thinkpad-x280";
  networking.usePredictableInterfaceNames = false;
  networking.wireless.iwd.enable = true;
}
