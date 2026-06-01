{ lib, ... }:
{
  networking.useDHCP = lib.mkForce true;
  networking.usePredictableInterfaceNames = lib.mkForce false;

  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.networkmanager.enable = true;

  networking.timeServers = [
    "pool.ntp.org"
    
    "ntp.aliyun.com"
    "ntp.tencent.com"
    
    "time.apple.com"
    "time.windows.com"
  ];
}
