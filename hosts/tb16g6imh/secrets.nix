{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/${hostName}/cliproxy.yaml" = {
    file = relative "secrets/hosts/${hostName}/cliproxy.yaml.age";
    mode = "0644";
  };
}
