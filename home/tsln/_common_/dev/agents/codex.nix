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
  home.packages = [
    pkgs.codex
  ];

  age.secrets."users/${username}/codex/config.toml" = {
    file = relative "secrets/users/${username}/codex/config.toml.age";
    path = "${homeDirectory}/.codex/config.toml";
    mode = "644";
  };
}
