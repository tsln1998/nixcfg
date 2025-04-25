{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/mihomo.yaml" = {
    file = relative "secrets/hosts/${hostName}/mihomo.yaml.age";
    mode = "0644";
  };
}
