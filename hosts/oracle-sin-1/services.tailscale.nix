{
  tools,
  config,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;

  key = "hosts/oracle-shared/tailscale.age";
in
{
  age.secrets.${key}.file = relative "secrets/${key}";

  services.tailscale.enable = true;
  services.tailscale.authKeyFile = secrets.${key}.path;
}
