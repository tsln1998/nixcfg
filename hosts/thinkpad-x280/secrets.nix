{ tools, ... }:
let
  inherit (tools) relative;
in
{
  age.secrets."hosts/thinkpad-x280/mihomo.yaml" = {
    file = relative "secrets/hosts/thinkpad-x280/mihomo.yaml.age";
    mode = "0644";
  };
}
