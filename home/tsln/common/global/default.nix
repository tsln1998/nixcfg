{ config, tools, ... }:
{
  imports = tools.scan ./.;

  home.username = "tsln";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "24.11";
}
