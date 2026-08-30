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

  catppuccin.enable = lib.mkOptionDefault false;
  catppuccin.autoEnable = lib.mkOptionDefault false;
  catppuccin.sources = catppuccinSources.overrideScope (
    final: prev: {
      whiskers = pkgs.catppuccin-whiskers;
    }
  );
}
