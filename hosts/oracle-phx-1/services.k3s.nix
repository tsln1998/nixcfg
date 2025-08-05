{
  tools,
  config,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;

  key = "hosts/oracle-shared/k3s";
in
{
  age.secrets.${key}.file = relative "secrets/${key}.age";

  services.k3s.enable = true;
  services.k3s.role = "agent";
  services.k3s.tokenFile = secrets.${key}.path;
  services.k3s.serverAddr = "https://100.64.0.1:6443";
}
