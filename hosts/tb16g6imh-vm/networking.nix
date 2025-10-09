{ lib, ... }:
{
  networking.hostName = "tb16g6imh-vm";
  networking.hostId = "454768f1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
}
