_: {
  systemd.services.xray = {
    serviceConfig = {
      RuntimeDirectory = "xray";
      RuntimeDirectoryMode = "0755";
    };
    environment = {
      XRAY_RAY_BUFFER_SIZE = "4";
    };
  };
}
