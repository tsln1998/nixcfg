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
    pkgs.repos.additions.codex
  ];

  age.secrets."users/${username}/codex/config.toml" = {
    file = relative "secrets/users/${username}/codex/config.toml.age";
    path = "${homeDirectory}/.codex/config.toml";
    mode = "644";
  };

  age.secrets."users/${username}/codex/auth.json" = {
    file = relative "secrets/users/${username}/codex/auth.json.age";
    path = "${homeDirectory}/.codex/auth.json";
    mode = "644";
  };
}
