{
  config,
  tools,
  pkgs,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
in
{
  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
    path = "${homeDirectory}/.pi/agent/models.json";
    mode = "644";
  };
  age.secrets."users/${username}/pi/agent/settings.json" = {
    file = relative "secrets/users/${username}/pi/agent/settings.json.age";
    path = "${homeDirectory}/.pi/agent/settings.json";
    mode = "644";
  };

  home.packages = [
    pkgs.repos.unstable.pi-coding-agent
  ];
}
