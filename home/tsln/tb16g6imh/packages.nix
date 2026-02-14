{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.repos.llm-agents.openspec
    pkgs.repos.llm-agents.opencode
    pkgs.repos.llm-agents.claude-code
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
