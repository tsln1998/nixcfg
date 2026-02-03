{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
  cfg = config.services.mihomo;
in
{
  services.mihomo = {
    enable = true;
    # tunMode = true;
    tproxyMode = true;
    package = pkgs.mihomo;
    webui = pkgs.zashboard;
    configFile = secrets."hosts/${hostName}/mihomo.yaml".path;
  };

  services.tproxy = {
    enable = cfg.tproxyMode;
    after = [ "mihomo.service" ];
    tcpTo = 7892;
    udpTo = 7892;
    dnsTo = 1053;
  };

  networking.firewall = {
    allowedTCPPorts = [ 7890 ];
    allowedUDPPorts = [ 7890 ];
    trustedInterfaces = lib.optionals (cfg.tunMode && !cfg.tproxyMode) [
      "tun0"
    ];
    checkReversePath = !(cfg.tunMode || cfg.tproxyMode);
  };
}
