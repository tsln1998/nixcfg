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
        "openai/gpt-6-luna"
        "openai/gpt-6-astra"
        "openai/gpt-6.1-sol"
        "openai/gpt-6.1-terra"
        "deepseek/deepseek-flash"
      ];

      modelThinkingLevels = {
        "openai/gpt-6-luna" = "max";
        "openai/gpt-6-astra" = "medium";
        "openai/gpt-6.1-sol" = "xhigh";
        "openai/gpt-6.1-terra" = "xhigh";
        "deepseek/deepseek-flash" = "high";
      };

      compaction = {
        enabled = true;

        modelOverrides = {
          "deepseek/deepseek-flash" = {
            reserveTokens = 128000;
            keepRecentTokens = 20480;
          };
        };
      };

      subagents = {
        agentOverrides = {
          scout = {
            model = "openai/gpt-6-luna";
            thinking = "max";
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
        pkgs.pi-extensions.hermes-memory.spec
        # 提供子代理支持
        pkgs.pi-extensions.subagents.spec
        # 网页搜索、URL 抓取及文档、视频内容提取
        pkgs.pi-extensions.web-access.spec
        # 在底栏显示模型、路径、Git、令牌、费用及耗时
        pkgs.pi-extensions.cometix-footer.spec
      ];
    };
  };

  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
  };
}
