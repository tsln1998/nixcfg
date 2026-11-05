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

  name = "magpie";
  workdir = "/var/lib/magpie";
in
{
  # Secrets
  age.secrets."hosts/${hostName}/${name}/config.env" = {
    file = relative "secrets/hosts/${hostName}/${name}/config.env.age";
    mode = "0644";
  };

  # Magpie work directory
  systemd.tmpfiles.rules = [
    "d ${workdir} 0755 root root -"
  ];

  # Magpie service configuration
  virtualisation.oci-containers.containers.magpie = {
    image = pkgs.managed-registry.magpie.ref;

    serviceName = name;

    environment = {
      TZ = "Asia/Shanghai";
    };

    volumes = [
      "${workdir}:/config"
    ];

    cmd = [
      "web"
      "--gateway"
      "--no-open"
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
