{ pkgs, ... }:
{
  home.packages = [
    pkgs.llm-agents.droid
    pkgs.llm-agents.cursor-agent
  ];
}
