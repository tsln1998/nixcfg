{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.openspec
    pkgs.llm-agents.opencode
    pkgs.llm-agents.droid
    pkgs.llm-agents.claude-code
    pkgs.llm-agents.claude-code-router
  ]
  ++ [
    # Development Tools
    pkgs.cloc
  ]
  ++ [
    # Github Client
    pkgs.github-cli
    # Fly.io Client
    pkgs.flyctl
  ];
}
