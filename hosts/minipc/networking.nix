_: {
  networking = {
    usePredictableInterfaceNames = false;
    firewall = {
      enable = true;
    };
    nftables = {
      enable = true;
    };
    networkmanager = {
      enable = true;
    };
    timeServers = [
      "pool.ntp.org"

      "ntp.aliyun.com"
      "ntp.tencent.com"

      "time.apple.com"
      "time.windows.com"
    ];
  };
}
