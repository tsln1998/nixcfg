{ inputs, lib, ... }:
_: prev:
let
  pkgs' = import inputs.nixpkgs-unstable {
    inherit (prev) config;
    inherit (prev.stdenv.hostPlatform) system;
  };

  # 包版本映射关系如下:
  #  null  -> 强制使用 unstable 替代
  #  0.0.0 -> 上游不存在该包时，使用 unstable 替代
  #  x.y.z -> 上游版本低于此版本时，使用 unstable 替代
  versions = {
    codex = null;
    pi-coding-agent = null;
  };
in
lib.mapAttrs (
  name: version:
  if !(prev ? ${name}) || version == null || lib.versionOlder prev.${name}.version version then
    pkgs'.${name}
  else
    prev.${name}
) versions
