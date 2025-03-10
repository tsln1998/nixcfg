{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.networking) hostName;
in
{
  age.secrets."hosts/thinkpad-x280/mihomo.yaml" = {
    file = relative "secrets/hosts/thinkpad-x280/mihomo.yaml.age";
    mode = "0644";
  };
  age.secrets."hosts/${hostName}/nezha-agent.yaml" = {
    file = relative "secrets/hosts/${hostName}/nezha-agent.yaml.age";
    mode = "0644";
  };
}
