{ config, ... }:
let
  inherit (config.services) tailscale;
in
{
  services.tailscale.enable = true;
  services.tailscale.openFirewall = true;
  services.tailscale.exit.enable = true;

  # Firewall
  networking.firewall.trustedInterfaces = [
    tailscale.interfaceName
  ];
}
