{ pkgs, ... }:
{
  programs.fastfetch.enable = true;
  programs.fastfetch.package = pkgs.fastfetch.minimal;
}
