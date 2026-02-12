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
      plugins = [ "github.com/mholt/caddy-l4@v0.0.0-20260104223739-97fa8c1b6618" ];
      hash = "sha256-tU1NDghF8lfnirMIhIrC08dBLtpds8Clpf0D2MydDh0=";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };
}
