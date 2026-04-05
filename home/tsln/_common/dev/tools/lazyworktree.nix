{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.additions.lazyworktree
  ];
}