{ lib, ... }:
{
  networking.hostName = "oracle-sin-1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
}
