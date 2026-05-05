{ pkgs, ... }:
{
  home.packages = [
    pkgs.llm-agents.openspec
  ];
}
