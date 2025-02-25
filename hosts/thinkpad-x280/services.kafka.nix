{ config, ... }:
let
  inherit (config.services) zookeeper;
in
{
  services.apache-kafka = {
    enable = true;
    settings = {
      "listeners" = [
        "PLAINTEXT://0.0.0.0:9092"
      ];
      "advertised.listeners" = [
        "PLAINTEXT://192.168.64.150:9092"
      ];
      "listener.security.protocol.map" = [
        "PLAINTEXT:PLAINTEXT"
      ];
      "zookeeper.connect" = "127.0.0.1:${builtins.toString zookeeper.port}";
      "log.dirs" = [
        "/tmp/kafka-logs"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    9092
  ];
}
