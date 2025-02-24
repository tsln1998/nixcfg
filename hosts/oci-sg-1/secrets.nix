{ tools, ... }:
let
  inherit (tools) relative;
in
{
  age.secrets."hosts/oci-sg-1/caddyfile" = {
    file = relative "secrets/hosts/oci-sg-1/caddyfile.age";
    mode = "0644";
  };
}
