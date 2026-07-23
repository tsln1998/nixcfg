{...}:
{
  programs.zellij = {
    enable = true;
    extraConfig = ''
      show_startup_tips false

      keybinds {
          shared_except "locked" {
              bind "Ctrl \\" { Detach; }
          }
          locked {
              bind "Ctrl \\" { Detach; }
          }
      }
    '';
  };

  home.shellAliases = {
    zj = "zellij";
  };
}
