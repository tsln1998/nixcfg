{ lib, pkgs, ... }:
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
        name = "Monaspace Neon";
        package = pkgs.monaspace;
      }
      {
        name = "Monaspace Neon NF";
        package = pkgs.nerd-fonts.monaspace;
      }
      {
        name = "Noto Sans CJK SC";
        package = pkgs.noto-fonts-cjk-sans;
      }
    ];
  };
}
