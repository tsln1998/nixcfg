{ config, tools,pkgs, ... }:
let
  inherit (tools) relative;
  inherit (config.home) username homeDirectory;
in
{
  home.packages = [
    pkgs.repos.llm-agents.opencode
  ];

  age.secrets."users/${username}/config/opencode/opencode.json" = {
    file = relative "secrets/users/${username}/config/opencode/opencode.json.age";
    path = "${homeDirectory}/.config/opencode/opencode.json";
    mode = "644";
  };

  age.secrets."users/${username}/config/opencode/oh-my-opencode.json" = {
    file = relative "secrets/users/${username}/config/opencode/oh-my-opencode.json.age";
    path = "${homeDirectory}/.config/opencode/oh-my-opencode.json";
    mode = "644";
  };
}