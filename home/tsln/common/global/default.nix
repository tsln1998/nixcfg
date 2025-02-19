{ tools, ... }:
{
  imports = tools.scan ./.;

  home.username = "tsln";
  home.homeDirectory = "/home/tsln";
  home.stateVersion = "24.11";
}
