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
    rtk = "0.48.0";
    pixi = "0.80.0";
    beads = "1.3.0";
    codex = null;
    herdr = "0.0.0";
    vscode = null;
    skills = "1.6.0";
    gitcomet = "0.2.3";
    mcporter = "0.13.0";
    codegraph = "0.0.0";
    pi-coding-agent = "0.86.1";
    vscode-extensions = null;
  };
in
lib.mapAttrs (
  name: version:
  if !(prev ? ${name}) || version == null || lib.versionOlder prev.${name}.version version then
    pkgs'.${name}
  else
    prev.${name}
) versions
