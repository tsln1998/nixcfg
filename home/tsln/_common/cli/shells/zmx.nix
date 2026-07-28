{ pkgs, ... }:
{
  home.packages = [
    pkgs.repos.unstable.zmx
  ];
  
  home.shellAliases = {
    zz = "zmx";
  };
}
