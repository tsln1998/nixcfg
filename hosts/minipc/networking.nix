{ lib, ... }:
let
  wan = [ "eth0" ];
in
{
  networking.useDHCP = lib.mkForce true;
  networking.usePredictableInterfaceNames = lib.mkForce false;

  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = map (name: "interface-name:${name}") wan;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
}
