{ ... }:
{
  networking.usePredictableInterfaceNames = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
}
