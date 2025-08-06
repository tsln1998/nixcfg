{
  lib,
  tools,
  config,
  ...
}:
let
  inherit (config.age) secrets;
  inherit (tools) relative;
  inherit (config.networking) hostName;

  key = "hosts/oracle-shared/k3s.age";
in
{
  # https://docs.k3s.io/cli/certificate#using-custom-ca-certificates
  # https://docs.k3s.io/cli/token
  age.secrets =
    lib.listToAttrs (
      lib.map
        (name: {
          name = "hosts/${hostName}/k3s/${name}";
          value = {
            file = relative "secrets/hosts/${hostName}/k3s/${name}.age";
            path = "/var/lib/rancher/k3s/server/tls/${name}";
          };
        })
        [
          "root-ca.crt"
          "root-ca.key"
          "root-ca.pem"
          "server-ca.crt"
          "server-ca.key"
          "server-ca.pem"
          "client-ca.crt"
          "client-ca.key"
          "client-ca.pem"
          "intermediate-ca.crt"
          "intermediate-ca.key"
          "intermediate-ca.pem"
          "request-header-ca.crt"
          "request-header-ca.key"
          "request-header-ca.pem"
          "service.key"
          "etcd/peer-ca.crt"
          "etcd/peer-ca.key"
          "etcd/peer-ca.pem"
          "etcd/server-ca.crt"
          "etcd/server-ca.key"
          "etcd/server-ca.pem"
        ]
    )
    // {
      ${key}.file = relative "secrets/${key}";
    };

  # k3s cluster (master node)
  services.k3s.enable = true;
  services.k3s.clusterInit = true;
  services.k3s.role = "server";
  services.k3s.tokenFile = secrets.${key}.path;
  services.k3s.extraFlags = [
    "--write-kubeconfig-mode 644"
    "--node-external-ip 100.64.0.1"
    "--disable traefik"
    "--disable local-storage"
    "--disable metrics-server"
  ];

  # k3s firewall
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      6443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };

}
