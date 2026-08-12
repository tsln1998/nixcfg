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

      defaultProvider = "openai";
      defaultModel = "gpt-5.6-terra";
      defaultThinkingLevel = "xhigh";
      defaultProjectTrust = "always";

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
        # 只读探索代码库，并在执行前先制定计划
        "npm:pi-plan"
        # 委派子代理，并支持脚本化多代理工作流
        "npm:pi-subagents"
        # 提供持久记忆、会话搜索及敏感信息扫描
        "npm:pi-hermes-memory"
      ];
    };
  };

  age.secrets."users/${username}/pi/agent/models.json" = {
    file = relative "secrets/users/${username}/pi/agent/models.json.age";
  };
}
