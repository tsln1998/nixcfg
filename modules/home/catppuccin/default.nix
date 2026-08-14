{
  lib,
  tools,
  pkgs,
  inputs,
  ...
}:
{
  imports = tools.scan ./.;

  catppuccin.autoEnable = lib.mkDefault false;
  catppuccin.sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (
    final: prev: {
      whiskers = pkgs.catppuccin-whiskers;
    }
  );
}
