{ lib, ... }:
{
  networking.hostName = "oracle-bat-1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
}
