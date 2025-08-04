{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  cfg = secrets."hosts/${hostName}/hysteria.yaml";
in
{
  virtualisation.oci-containers.containers.hysteria = {
    image = "tobyxdd/hysteria:v2.6.2";
    volumes = [
      "${cfg.path}:/etc/hysteria.yaml"
    ];
    cmd = [
      "server"
      "-c"
      "/etc/hysteria.yaml"
    ];
  };
}
