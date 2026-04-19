{ config, pkgs, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.caddy = {
    enable = true;
    configFile = secrets."hosts/${hostName}/caddyfile".path;
    package = pkgs.caddy;
  };

  systemd.services.caddy = {
    reloadTriggers = [
      secrets."hosts/${hostName}/caddyfile".file
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };
}
