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
      tuiMode = "fullscreen";

      defaultProvider = "deepseek";
      defaultModel = "deepseek-v4-flash";
      defaultThinkingLevel = "xhigh";
      defaultProjectTrust = "always";

      enabledModels = [
        "openai/gpt-6-astra"
        "openai/gpt-5.6-sol"
        "openai/gpt-5.6-terra"
        "openai/gpt-5.6-luna"
        "openai/gpt-5.3-codex-spark"
        "deepseek/deepseek-v4-flash"
      ];

      subagents = {
        agentOverrides = {
          scout = {
            model = "openai/gpt-5.6-luna";
            thinking = "medium";
            fallbackModels = [ ];
          };
          researcher = {
            model = "openai/gpt-5.6-terra";
            thinking = "medium";
            fallbackModels = [ ];
          };
          reviewer = {
            model = "openai/gpt-5.6-terra";
            thinking = "xhigh";
            fallbackModels = [ ];
          };
          worker = {
            model = "openai/gpt-5.6-sol";
            thinking = "xhigh";
            fallbackModels = [ ];
          };
          oracle = {
            model = "openai/gpt-6-astra";
            thinking = "medium";
            fallbackModels = [ ];
          };
          delegate = {
            model = "openai/gpt-5.6-sol";
            thinking = "xhigh";
            fallbackModels = [ ];
          };
          evidence-auditor = {
            model = "openai/gpt-5.6-terra";
            thinking = "xhigh";
            fallbackModels = [ ];
          };
        };
      };

      retry = {
        enabled = true;
        maxRetries = 3;
      };

      packages = [
        # 提供持久记忆、会话搜索及敏感信息扫描
        "npm:pi-hermes-memory"
        # 提供子代理支持
        "npm:pi-subagents"
      ];
    };
  };

  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
  };
}
