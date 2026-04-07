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
    pkgs.repos.llm-agents.claude-code
  ];

  age.secrets."users/${username}/config/profile.d/claude.sh" = {
    file = relative "secrets/users/${username}/config/profile.d/claude.sh.age";
    path = "${homeDirectory}/.config/profile.d/claude.sh";
    mode = "644";
  };
}
