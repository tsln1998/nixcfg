{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  name = "cpa";
in
{
  # Secrets
  age.secrets."hosts/${hostName}/${name}/config.yaml" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.yaml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/${name}/config.env" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.env.age";
    mode = "0644";
  };

  # CLIProxy service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = "eceasy/cli-proxy-api:v7.2.81";

    serviceName = name;

    volumes = [
      "${secrets."hosts/${hostName}/${name}/config.yaml".path}:/CLIProxyAPI/config.yaml"
      "/var/lib/cliproxyapi:/CLIProxyAPI/static"
    ];

    environmentFiles = [
      secrets."hosts/${hostName}/${name}/config.env".path
    ];

    extraOptions = [
      "--network=host"
    ];
  };

  systemd.services.${name} = {
    restartTriggers = [
      secrets."hosts/${hostName}/${name}/config.yaml".file
      secrets."hosts/${hostName}/${name}/config.env".file
    ];
  };
}
