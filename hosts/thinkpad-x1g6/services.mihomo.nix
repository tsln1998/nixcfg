{
  config,
  pkgs,
  tools,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/mihomo.yaml" = {
    file = relative "secrets/hosts/${hostName}/mihomo.yaml.age";
    mode = "0644";
  };

  services.clash = {
    enable = true;
    tproxyMode = true;
    package = pkgs.mihomo;
    webui = pkgs.metacubexd;
    configFile = secrets."hosts/${hostName}/mihomo.yaml".path;
  };

  services.tproxy = {
    enable = true;
    after = [ "clash.service" ];
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
}
