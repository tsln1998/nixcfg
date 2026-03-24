{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.additions.zmx
  ];

  home.shellAliases = {
    z = "zmx";
  };

  programs.zsh = {
    initContent = ''
      eval "$(zmx completions zsh)"
    '';
  };
}
