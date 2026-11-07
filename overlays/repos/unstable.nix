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
    qq = "7.0.2-2026-09-24";
    rtk = "0.48.0";
    pixi = "0.80.0";
    keka = "1.6.8";
    xray = "26.9.0";
    beads = "1.3.0";
    codex = null;
    herdr = "0.0.0";
    vscode = null;
    skills = "1.6.0";
    wechat = "4.1.15.55-270135";
    chatgpt = "26.1023.50603";
    gitcomet = "0.2.3";
    mcporter = "0.13.0";
    hysteria = "2.13.0";
    codegraph = "0.0.0";
    tableplus = "662";
    cyberduck = "9.5.4.45528";
    notion-app = "7.25.1";
    ghostty-bin = "1.4.0";
    pi-coding-agent = null;
    keepingyouawake = "0.0.0";
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
