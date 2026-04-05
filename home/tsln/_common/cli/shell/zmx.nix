{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.nur.avycado13.zmx
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
