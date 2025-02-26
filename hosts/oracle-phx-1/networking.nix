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
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
