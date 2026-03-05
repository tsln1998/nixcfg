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

      ENABLE_RATE_LIMIT = "true";
      ENABLE_SMART_PROBING = "true";
      ENABLE_CIRCUIT_BREAKER_ON_NETWORK_ERRORS = "true";
    };

    environmentFiles = [
      secrets."hosts/${hostName}/cch.env".path
    ];

    ports = [
      "127.0.0.1:3000:3000"
    ];
  };
}
