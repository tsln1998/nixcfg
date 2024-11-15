{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.bat ];
  environment.shellAliases.cat = "bat -p";
}
