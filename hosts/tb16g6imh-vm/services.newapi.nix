{ config, lib, ... }:
let
  inherit (lib) head;

  app = "newapi";
  image = "calciumion/new-api";
  version = "v0.8.9.2.1";

  # 提取数据库地址
  dbGateway = config.networking.defaultGateway.interface;
  dbOutbound = config.networking.interfaces.${dbGateway};
  dbOutboundAddrs = head dbOutbound.ipv4.addresses;
  dbOutboundIPv4 = dbOutboundAddrs.address;
  dbOutboundPort = toString config.services.postgresql.settings.port;
in
{
  virtualisation.oci-containers.containers.${app} = {
    image = "${image}:${version}";
    ports = [
      "3000:3000"
    ];
    environment = {
      SQL_DSN = "postgres://postgres:postgres@${dbOutboundIPv4}:${dbOutboundPort}/newapi";
    };
  };

  services.postgresql.ensureDatabases = [ "newapi" ];

  networking.firewall.allowedTCPPorts = [
    3000
  ];
}
