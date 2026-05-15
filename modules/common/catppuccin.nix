{ pkgs, inputs, ... }:
{
  catppuccin.sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (
    final: prev: {
      whiskers = pkgs.catppuccin-whiskers;
    }
  );
}
