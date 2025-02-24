{ tools, ... }:
let
  inherit (tools) relative;
in
{
  age.secrets."hosts/oracle-sin-1/caddyfile" = {
    file = relative "secrets/hosts/oracle-sin-1/caddyfile.age";
    mode = "0644";
  };
}
