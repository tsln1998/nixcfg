{ pkgs, ... }:
{
  programs.java = {
    enable = true;
    package = pkgs.zulu;
  };
}
