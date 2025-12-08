{ inputs, ... }:
final: _: {
  llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};
}
