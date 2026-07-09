{
  lib,
  config,
  ...
}:
let
  inherit (config.services) tailscale;
  inherit (config.networking) firewall;
in
{
  services.tailscale.enable = true;
  services.tailscale.openFirewall = true;

  # Firewall
  networking.nftables = lib.optionalAttrs firewall.enable {
    enable = lib.mkForce true;
    tables = {
      tailscale = {
        # TCP   22: OpenSSH Server
        # TCP  139: NetBIOS Session
        # TCP  445: Microsoft Direct Host SMB
        # TCP 3702: Web Services Dynamic Discovery
        # UDP  137: NetBIOS Name Service
        # UDP  138: NetBIOS Datagram
        # UDP 5353: mDNS
        # UDP 5357: Web Services Dynamic Discovery
        family = "inet";
        content = ''
          chain input {
            type filter hook input priority -10; policy accept;

            iifname "${tailscale.interfaceName}" tcp dport { 139, 445, 3792 } drop;
            iifname "${tailscale.interfaceName}" udp dport { 137, 138, 5353, 5357 } drop;
          }
        '';
      };
    };
  };

  networking.firewall.trustedInterfaces = [
    tailscale.interfaceName
  ];
}
