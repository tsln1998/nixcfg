{ pkgs, ... }:
{
  home.packages = [
    # LLM Agents
    pkgs.llm-agents.droid
    pkgs.llm-agents.openspec
    pkgs.llm-agents.claude-code
  ]
  ++ [
    # Development Tools
    pkgs.cloc
    (pkgs.caddy.withPlugins {
      plugins = [ "github.com/mholt/caddy-l4@v0.0.0-20260104223739-97fa8c1b6618" ];
      hash = "sha256-9tFRk+ULLh99eSPiNtiusH9yqcIJkVuJOEaeS43s8Tc=";
    })
  ]
  ++ [
    # Github Client
    pkgs.github-cli
    # Fly.io Client
    pkgs.flyctl
  ];
}
