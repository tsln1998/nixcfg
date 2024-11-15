{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.eza ];
  environment.shellAliases.ls = "eza";
  environment.shellAliases.ll = "eza -l";
}
