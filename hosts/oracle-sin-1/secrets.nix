{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/hysteria.yaml" = {
    file = relative "secrets/hosts/${hostName}/hysteria.yaml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/xray.json" = {
    file = relative "secrets/hosts/${hostName}/xray.json.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/rrc.env" = {
    file = relative "secrets/hosts/${hostName}/rrc.env.age";
    mode = "0644";
  };
}
