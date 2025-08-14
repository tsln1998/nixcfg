{ ... }:
let
  interface = "eth0";
  address = "172.30.224.2";
  gateway = "172.30.224.1";
  prefixLength = 24;
in
{
  networking.hostName = "tb16g6imh-vm";
  networking.hostId = "454768f1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
  networking.interfaces.${interface}.ipv4.addresses = [
    {
      address = address;
      prefixLength = prefixLength;
    }
  ];
  networking.defaultGateway = {
    address = gateway;
    interface = interface;
  };
  networking.nameservers = [
    "223.5.5.5"
    "223.6.6.6"
  ];
}
