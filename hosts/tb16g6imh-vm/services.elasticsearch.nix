{ ... }:
{
  services.elasticsearch = {
    enable = false;
    listenAddress = "0.0.0.0";
  };

  networking.firewall.allowedTCPPorts = [
    9200
    9300
  ];
}
