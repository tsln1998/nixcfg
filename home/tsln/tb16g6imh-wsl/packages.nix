{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.repos.additions.codex
    pkgs.repos.llm-agents.opencode
    pkgs.repos.llm-agents.claude-code
  ]
  ++ [
    # LLM Plugins
    pkgs.repos.llm-agents.openspec
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
