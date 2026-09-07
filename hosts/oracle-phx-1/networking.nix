{ ... }:
{
  boot.kernel.sysctl = {
    # Retain 16 MiB socket limits for Hysteria's UDP buffers.
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    # Allow TCP buffer growth for a 50 Mbps path with a 300 ms RTT.
    "net.ipv4.tcp_rmem" = "4096 131072 8388608";
    "net.ipv4.tcp_wmem" = "4096 65536 8388608";
  };

  networking.usePredictableInterfaceNames = false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
}
