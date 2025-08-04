{
  config,
  pkgs,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (config.networking) hostName;

  cfg = secrets."hosts/${hostName}/caddyfile".path;
  entry = pkgs.writeTextFile {
    name = "caddy-entrypoint.sh";
    text = ''
      #!/bin/ash
      caddy add-package github.com/mholt/caddy-l4@v0.0.0-20250530154005-4d3c80e89c5f
      caddy run
    '';
    executable = true;
  };
in
{
  virtualisation.oci-containers.containers.caddy = {
    image = "caddy:2.10";
    dependsOn = [
      "xtls"
      "hysteria"
      "crproxy"
    ];
    ports = [
      "80:80"
      "443:443"
    ];
    networks = [
      "shared"
    ];
    volumes = [
      "${cfg}:/etc/caddy/Caddyfile"
      "${entry}:/usr/bin/entrypoint.sh"
    ];
    entrypoint = "/usr/bin/entrypoint.sh";
  };
}
