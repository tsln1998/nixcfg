{ tools, ... }:
{
  imports = [ (tools.module "<nixos-wsl>") ];

  wsl.enable = true;
  wsl.defaultUser = "tsln";
  wsl.startMenuLaunchers = true;
  boot.tmp.useTmpfs = true;
}
