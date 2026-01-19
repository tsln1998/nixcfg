{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.droid
    pkgs.llm-agents.openspec
    pkgs.llm-agents.opencode
    pkgs.llm-agents.claude-code
  ]
  ++ [
    # Development Tools
    pkgs.cloc
    pkgs.bun
  ]
  ++ [
    # Github Client
    pkgs.github-cli
    # Fly.io Client
    pkgs.flyctl
  ];
}
