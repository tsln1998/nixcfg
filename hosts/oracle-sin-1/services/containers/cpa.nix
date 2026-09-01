{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  name = "cpa";
  secret = "hosts/${hostName}/${name}/config.yaml";
  static = "/var/lib/cliproxyapi";
in
{
  # Secrets
  age.secrets.${secret} = {
    file = relative "secrets/${secret}.age";
    mode = "0644";
  };

  # CLIProxy service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = "eceasy/cli-proxy-api:v7.2.147";

    serviceName = name;

    volumes = [
      "${static}:/CLIProxyAPI/static"
      "${secrets.${secret}.path}:/CLIProxyAPI/config.yaml"
    ];

    extraOptions = [
      "--network=host"
    ];
  };

  systemd.services.${name} = {
    restartTriggers = [
      secrets.${secret}.file
    ];
  };
}
