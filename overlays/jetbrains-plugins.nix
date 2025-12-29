{ inputs, ... }:
final: _: {
  jetbrains-plugins = inputs.jetbrains-plugins.plugins.${final.stdenv.hostPlatform.system};
}
