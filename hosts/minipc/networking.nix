{ lib, ... }:
{
  networking.useDHCP = lib.mkForce true;
  networking.usePredictableInterfaceNames = lib.mkForce false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.networkmanager.enable = true;
}
