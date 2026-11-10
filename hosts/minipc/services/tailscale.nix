{ config, ... }:
let
  inherit (config.services) tailscale;
in
{
  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      ssh = {
        enable = true;
      };
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
