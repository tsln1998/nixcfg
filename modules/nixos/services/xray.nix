_: {
  systemd.services.xray.serviceConfig = {
    RuntimeDirectory = "xray";
    RuntimeDirectoryMode = "0755";
  };
}
