{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "full";
    subpixelRendering = "rgb";
    defaultFonts = {
      serif = [
        "Noto Serif CJK SC"
        "Noto Serif CJK TC"
        "Noto Serif CJK JP"
        "Noto Serif CJK KR"
      ];
      sansSerif = [
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
      ];
      monospace = [
        "Monaspace Neon"
        "Monaspace Neon NF"
      ];
      emoji = [
        "Noto Color Emoji"
      ];
    };
  };

  home.packages = with pkgs; [
    monaspace
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.monaspace
  ];
}
