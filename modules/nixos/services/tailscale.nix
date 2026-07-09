{ config, lib, ... }:
let
  inherit (config.services.tailscale)
    enable
    openFirewall
    relay
    exit
    ;
  inherit (config.networking) nftables;
in
{
  options.services.tailscale = {
    exit = {
      enable = lib.mkEnableOption "Enable tailscale exit node";
    };
    relay = {
      enable = lib.mkEnableOption "Enable tailscale peer relay";
      port = lib.mkOption {
        type = lib.types.port;
        default = 40000;
        description = "tailscale peer relay port";
      };
    };
  };

  config = lib.mkIf enable {
    # Set flags
    services.tailscale.extraSetFlags =
      (lib.optionals relay.enable [
        "--relay-server-port=${toString relay.port}"
      ])
      ++ (lib.optionals exit.enable [
        "--advertise-exit-node"
      ]);

    # Exit node
    boot.kernel.sysctl = lib.optionalAttrs exit.enable {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    # Peer relay
    networking.firewall.allowedUDPPorts = lib.optionals (relay.enable && openFirewall) [
      relay.port
    ];

    # Nftables
    systemd.services.tailscaled.environment = lib.optionalAttrs nftables.enable {
      TS_DEBUG_FIREWALL_MODE = "nftables";
    };
  };
}
