{
  config,
  tools,
  pkgs,
  ...
}:
let
  inherit (tools) relative;
  inherit (config.age) secrets;
  inherit (config.home) username;
in
{
  programs.pi = {
    enable = true;
    package = pkgs.repos.unstable.pi-coding-agent;
    extraPackages = [ pkgs.nodejs ];
    models = secrets."users/${username}/pi/agent/models.json".path;
    settings = {
      theme = "dark";
      defaultProvider = "openai";
      defaultModel = "gpt-5.6-terra";
      enabledModels = [
        "openai/gpt-5.6-sol"
        "openai/gpt-5.6-terra"
        "openai/gpt-5.6-luna"
        "openai/gpt-5.3-codex-spark"
      ];
      retry = {
        enabled = true;
        maxRetries = 3;
      };
      packages = [
        "npm:pi-subagents"
        "npm:pi-plan"
      ];
    };
  };

  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
  };
}
