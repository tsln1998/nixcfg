{ lib, ... }:
{
  networking.hostName = "thinkpad-x280";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
  networking.wireless.iwd.enable = true;

  boot.kernelModules = [
    "iwlwifi"
  ];
}
