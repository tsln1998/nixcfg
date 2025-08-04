{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  cfg = secrets."hosts/${hostName}/xray.json";
in
{
  virtualisation.oci-containers.containers.xtls = {
    image = "ghcr.io/xtls/xray-core:25.8.3";
    volumes = [
      "${cfg.path}:/usr/local/etc/xray/config.json"
    ];
  };
}
