{
  tools,
  pkgs,
  inputs,
  ...
}:
{
  imports = tools.scan ./.;

  catppuccin.sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (
    final: prev: {
      whiskers = pkgs.catppuccin-whiskers;
    }
  );

  catppuccin.gemini-cli.enable = false;
}
