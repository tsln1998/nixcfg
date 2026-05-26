{ config, lib, ... }:
let
  inherit (config.services.tailscale) enable openFirewall relay;
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

    networking.firewall.allowedUDPPorts = lib.optionals openFirewall [
      relay.port
    ];
  };
}
