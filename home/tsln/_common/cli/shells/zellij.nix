{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    package = pkgs.repos.unstable-2511.zellij;
    extraConfig = ''
      show_startup_tips false
      show_release_notes false
    '';
  };

  home.shellAliases = {
    zj = "zellij";
  };
}
