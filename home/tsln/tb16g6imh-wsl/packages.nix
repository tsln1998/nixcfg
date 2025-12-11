{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.openspec
    pkgs.llm-agents.opencode
    pkgs.llm-agents.cursor-agent
    pkgs.llm-agents.droid
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
