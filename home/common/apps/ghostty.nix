{ ... }:
{
  programs.ghostty = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      font-size = 10;
      font-family = "Fira Code";
    };
  };
}
