{ inputs, ... }:
final: _: {
  agenix = inputs.agenix.packages.${final.system}.default;
}
