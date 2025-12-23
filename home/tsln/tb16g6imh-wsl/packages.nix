{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.openspec
    pkgs.llm-agents.claude-code
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
