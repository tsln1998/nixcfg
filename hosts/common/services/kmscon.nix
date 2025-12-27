{ lib,pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    package = pkgs.kmscon;

    hwRender = true;
    extraConfig = lib.strings.concatStringsSep "\n" [
      "font-size=12"
      "font-dpi=144"
    ];

    fonts = [
      {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      }
      {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      }
      {
        name = "Noto Sans CJK SC";
        package = pkgs.noto-fonts-cjk-sans;
      }
    ];
  };
}
