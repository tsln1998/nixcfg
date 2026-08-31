{ config, lib, ... }:
let
  inherit (config.services) resolved;
  inherit (config.networking) nftables networkmanager;

  # extract base setting
  inherit (config.services.tailscale)
    enable
    openFirewall
    ;

  # extract features setting
  inherit (config.services.tailscale)
    relay
    exit
    magic-dns
    ;
in
{
  options.services.tailscale = {
    exit = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable tailscale exit node";
      };
    };

    relay = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable tailscale peer relay";
      };
      port = lib.mkOption {
        type = lib.types.port;
        default = 40000;
        description = "tailscale peer relay port";
      };
    };

    magic-dns = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable tailscale magic-dns";
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
      ])
      ++ [
        "--accept-dns=${lib.boolToString magic-dns.enable}"
      ];

    # Peer relay
    networking.firewall.allowedUDPPorts = lib.optionals (relay.enable && openFirewall) [
      relay.port
    ];

    # Exit node
    # See: https://tailscale.com/docs/features/subnet-routers#enable-ip-forwarding
    boot.kernel.sysctl = lib.optionalAttrs exit.enable {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    # MagicDNS
    # See: https://tailscale.com/docs/reference/linux-dns#networkmanager--systemd-resolved
    networking.networkmanager = lib.optionalAttrs (magic-dns.enable && resolved.enable && networkmanager.enable) {
      dns = lib.mkForce "systemd-resolved";
    };

    # Nftables
    # See: https://tailscale.com/docs/features/firewall-mode
    systemd.services.tailscaled.environment = lib.optionalAttrs nftables.enable {
      TS_DEBUG_FIREWALL_MODE = "nftables";
    };
  };
}
