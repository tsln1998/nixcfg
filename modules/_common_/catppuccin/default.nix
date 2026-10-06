{
  lib,
  tools,
  pkgs,
  inputs,
  ...
}:
let
  catppuccinSources = (import inputs.catppuccin.outPath { inherit pkgs; }).packages;
in
{
  imports = tools.scan ./.;

  catppuccin.enable = lib.mkDefault false;
  catppuccin.autoEnable = lib.mkDefault false;
  catppuccin.sources =
    (catppuccinSources.overrideScope (
      final: prev: {
        # 修正上游 catppuccin 未使用 whiskers 缓存的问题
        whiskers = pkgs.catppuccin-whiskers;
      }
    ))
    // {
      # 修正上游 catppuccin 无法跨平台求值
      starship = catppuccinSources.sources.starship + "/themes";
      obsidian = catppuccinSources.sources.obsidian;
    };
}
