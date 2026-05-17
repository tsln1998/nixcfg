{ config, tools, ... }:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
in
{
  age.secrets."users/${username}/kube/config" = {
    file = relative "secrets/users/${username}/kube/config.age";
    path = "${homeDirectory}/.kube/config";
    mode = "644";
  };
}
