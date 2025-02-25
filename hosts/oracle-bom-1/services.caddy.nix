{ config, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.caddy = {
    enable = true;
    configFile = secrets."hosts/${hostName}/caddyfile".path;
  };
}
