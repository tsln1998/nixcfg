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

  name = "substore";
  workdir = "/var/lib/substore";
in
{
  # Secrets
  age.secrets."hosts/${hostName}/${name}/config.env" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.env.age";
    mode = "0644";
  };

  # SubStore work directory
  systemd.tmpfiles.rules = [
    "d ${workdir} 0755 root root -"
  ];

  # SubStore service configuration
  virtualisation.oci-containers.containers.${name} = {
    image = pkgs.managed-registry.substore.ref;

    serviceName = name;

    environment = {
      TZ = "Asia/Shanghai";
    };

    volumes = [
      "${workdir}:/opt/app/data"
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
      secrets."hosts/${hostName}/${name}/config.env".file
    ];
  };
}
