{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.droid
    pkgs.llm-agents.cursor-agent
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
