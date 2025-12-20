{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.droid
    pkgs.llm-agents.openspec
    pkgs.llm-agents.claude-code
  ]
  ++ [
    # GUI Applications
    pkgs.code-cursor-fhs
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
