{ lib, ... }:
{
  networking.hostName = "oracle-phx-1";
  networking.useDHCP = lib.mkDefault true;
  networking.usePredictableInterfaceNames = false;
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
  };
}
