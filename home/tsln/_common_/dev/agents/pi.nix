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
    package = pkgs.pi-coding-agent;
    extraPackages = [ pkgs.nodejs ];
    models = secrets."users/${username}/pi/agent/models.json".path;
    settings = {
      theme = "dark";
      tuiMode = "fullscreen";
      hideThinkingBlock = true;

      defaultProvider = "deepseek";
      defaultModel = "deepseek-flash";
      defaultThinkingLevel = "xhigh";
      defaultProjectTrust = "always";

      enabledModels = [
        "openai/gpt-6-astra"
        "openai/gpt-6-luna"
        "openai/gpt-6.1-sol"
        "deepseek/deepseek-flash"
      ];

      modelThinkingLevels = {
        "deepseek/deepseek-flash" = "high";
      };

      compaction = {
        enabled = true;

        modelOverrides = {
          "deepseek/deepseek-flash" = {
            reserveTokens = 128000;
            keepRecentTokens = 20000;
          };
        };
      };

      subagents = {
        agentOverrides = {
          scout = {
            model = "openai/gpt-6-luna";
            thinking = "medium";
          };
          researcher = {
            model = "openai/gpt-6.1-sol";
            thinking = "medium";
          };
          reviewer = {
            model = "openai/gpt-6.1-sol";
            thinking = "xhigh";
          };
          worker = {
            model = "openai/gpt-6.1-sol";
            thinking = "xhigh";
          };
          oracle = {
            model = "openai/gpt-6-astra";
            thinking = "medium";
          };
          delegate = {
            model = "openai/gpt-6.1-sol";
            thinking = "xhigh";
          };
          evidence-auditor = {
            model = "openai/gpt-6.1-sol";
            thinking = "xhigh";
          };
        };
      };

      retry = {
        enabled = true;
        maxRetries = 3;
      };

      packages = [
        # 提供持久记忆、会话搜索及敏感信息扫描
        "npm:pi-hermes-memory@0.9.10"
        # 提供子代理支持
        "npm:pi-subagents@0.76.0"
      ];
    };
  };

  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
  };
}
