{ tools, ... }:
{
  imports = [ (tools.module "<nixos-wsl>") ];

  wsl.enable = true;
  wsl.defaultUser = "tsln";
}
