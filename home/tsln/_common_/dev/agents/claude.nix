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
    pkgs.claude-code
  ];

  age.secrets."users/${username}/claude/settings.json" = {
    file = relative "secrets/users/${username}/claude/settings.json.age";
    path = "${homeDirectory}/.claude/settings.json";
    mode = "644";
  };
}
