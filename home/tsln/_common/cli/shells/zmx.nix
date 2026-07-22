{ pkgs, ... }:
{
  home.packages = [
    pkgs.zmx
  ];
  
  home.shellAliases = {
    zz = "zmx";
  };
}
