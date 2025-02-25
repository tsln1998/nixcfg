{ config, pkgs, ... }:
let
  inherit (config.age) secrets;
in
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    package = pkgs.mihomo;
    webui = pkgs.metacubexd;
    configFile = secrets."hosts/thinkpad-x280/mihomo.yaml".path;
  };

  networking.firewall = {
    allowedTCPPorts = [
      9090
    ];
    trustedInterfaces = [
      "tun0"
    ];
    checkReversePath = false;
  };
}
