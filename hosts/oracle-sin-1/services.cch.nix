{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  virtualisation.oci-containers.containers.cch = {
    image = "ghcr.io/ding113/claude-code-hub:v0.6.1";

    environment = {
      TZ = "Asia/Shanghai";
      SESSION_TTL = "300";
      AUTO_MIGRATE = "true";
      ENABLE_RATE_LIMIT = "true";
    };

    environmentFiles = [
      secrets."hosts/${hostName}/cch.env".path
    ];

    ports = [
      "127.0.0.1:3000:3000"
    ];
  };
}
