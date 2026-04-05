{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.llm-agents.openspec
  ];
}