{
  pkgs,
  tools,
  config,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;

  key = "hosts/oracle-shared/k3s.age";
in
{
  age.secrets.${key}.file = relative "secrets/${key}";

  services.k3s.enable = true;
  services.k3s.clusterInit = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = [
    "--node-external-ip 100.64.0.1"
    "--disable traefik"
    "--disable local-storage"
    "--disable metrics-server"
  ];
}
