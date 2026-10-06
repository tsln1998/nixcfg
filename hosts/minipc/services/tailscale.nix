{ config, ... }:
let
  inherit (config.services) tailscale;
in
{
  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      exit = {
        enable = true;
      };
    };
  };

  # Firewall
  networking.firewall.trustedInterfaces = [
    tailscale.interfaceName
  ];
}
