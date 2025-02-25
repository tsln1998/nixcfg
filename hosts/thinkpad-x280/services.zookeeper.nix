{...}: {
  services.zookeeper = {
    enable = true;
    port = 2181;
  };
}