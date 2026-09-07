{ ... }:
{
  boot.kernel.sysctl = {
    # Allow buffer growth for a 1 Gbps path with a 200 ms RTT.
    "net.core.rmem_max" = 67108864;
    "net.core.wmem_max" = 67108864;
    "net.ipv4.tcp_rmem" = "4096 131072 67108864";
    "net.ipv4.tcp_wmem" = "4096 65536 67108864";
  };

  networking.usePredictableInterfaceNames = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
}
