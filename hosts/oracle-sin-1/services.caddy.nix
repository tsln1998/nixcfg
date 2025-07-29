{ config, pkgs, ... }:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;
in
{
  services.caddy = {
    enable = true;
    configFile = secrets."hosts/${hostName}/caddyfile".path;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/mholt/caddy-l4@v0.0.0-20250530154005-4d3c80e89c5f" ];
      hash = "sha256-uo3mVKqijNUztHLm7tXtgSUPVxzkO9TfF+CPJ01gAN4=";
    };
  };
}
