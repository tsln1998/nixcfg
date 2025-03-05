{ config, pkgs, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.clash = {
    enable = true;
    tproxyMode = true;
    package = pkgs.mihomo;
    webui = pkgs.metacubexd;
    configFile = secrets."hosts/${hostName}/mihomo.yaml".path;
  };

  services.tproxy = {
    enable = true;
    after = [ "mihomo.service" ];
    tcpTo = 7891;
    udpTo = 7891;
    dnsTo = 1053;
  };

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      9090
    ];
    trustedInterfaces = [
      "tun0"
    ];
    checkReversePath = false;
  };

  environment.systemPackages = [
    pkgs.q
    pkgs.nali
  ];
}
