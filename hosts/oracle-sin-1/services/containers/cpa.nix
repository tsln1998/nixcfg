{
  config,
  pkgs,
  tools,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  name = "cpa";
  secret = "hosts/${hostName}/${name}/config.yaml";
  workdir = "/var/lib/cliproxyapi";
in
{
  # Secrets
  age.secrets.${secret} = {
    file = relative "secrets/${secret}.age";
    mode = "0644";
  };

  # CLIProxy work directory
  systemd.tmpfiles.rules = [
    "d ${workdir} 0755 root root -"
  ];

  # CLIProxy service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = pkgs.managed-registry.cliproxyapi.ref;

    serviceName = name;

    volumes = [
      "${workdir}:/CLIProxyAPI/static"
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
