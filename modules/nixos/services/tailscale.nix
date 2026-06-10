{ config, lib, ... }:
let
  inherit (config.services.tailscale) enable openFirewall relay;
  inherit (config.networking) nftables;
in
{
  options.services.tailscale.relay = {
    enable = lib.mkEnableOption "Enable tailscale peer relay";
    port = lib.mkOption {
      type = lib.types.port;
      default = 40000;
      description = "tailscale peer relay port";
    };
  };

  config = lib.mkIf (enable && relay.enable) {
    services.tailscale.extraSetFlags = [
      "--relay-server-port=${toString relay.port}"
    ];

    systemd.services.tailscaled.environment = lib.mkIf nftables.enable {
      TS_DEBUG_FIREWALL_MODE = "nftables";
    };

    networking.firewall.allowedUDPPorts = lib.optionals openFirewall [
      relay.port
    ];
  };
}
