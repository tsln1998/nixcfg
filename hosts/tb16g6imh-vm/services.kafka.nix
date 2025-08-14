{ config, lib, ... }:
let
  inherit (lib) head;

  state = "apache-kafka";
  clusterId = "f5abce76-0e8b-4b83-962a-a517a23816b4";

  networkGateway = config.networking.defaultGateway.interface;
  networkInterface = config.networking.interfaces.${networkGateway};
  networkIPv4 = head networkInterface.ipv4.addresses;
in
{
  services.apache-kafka = {
    enable = true;
    clusterId = clusterId;
    formatLogDirs = true;
    settings = {
      "node.id" = 0;
      "log.dirs" = [
        "/var/lib/${state}"
      ];
      "listeners" = [
        "PLAINTEXT://0.0.0.0:9092"
        "CONTROLLER://0.0.0.0:9093"
      ];
      "advertised.listeners" = [
        "PLAINTEXT://${networkIPv4.address}:9092"
        "CONTROLLER://127.0.0.1:9093"
      ];
      "listener.security.protocol.map" = [
        "PLAINTEXT:PLAINTEXT"
        "CONTROLLER:PLAINTEXT"
      ];
      "controller.listener.names" = [
        "CONTROLLER"
      ];
      "controller.quorum.voters" = [
        "0@127.0.0.1:9093"
      ];
      "process.roles" = [
        "broker"
        "controller"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    9092
    9093
  ];
}
