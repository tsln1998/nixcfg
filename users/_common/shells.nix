{ pkgs, ... }:
{
  # Global user configuration
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;

  # Global user shells
  programs.zsh.enable = true;
  programs.bash.enable = true;
}
