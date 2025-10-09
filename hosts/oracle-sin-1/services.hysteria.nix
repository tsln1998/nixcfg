{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.hysteria = {
    enable = true;
    configFile = secrets."hosts/${hostName}/hysteria.yaml".path;
  };

  networking.nftables = {
    tables = {
      hysteria = {
        family = "ip";
        content = ''
          chain prerouting {
            type nat hook prerouting priority -100
            iifname "eth0" udp dport 20000-50000 dnat to :443
          }
        '';
      };
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 443 ];
  };
}
