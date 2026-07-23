{...}:
{
  programs.zellij = {
    enable = true;
    extraConfig = ''
      show_startup_tips false
    '';
  };

  home.shellAliases = {
    zj = "zellij";
  };
}
