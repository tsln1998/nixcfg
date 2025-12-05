{
  config,
  tools,
  lib,
  ...
}:
{
  imports = tools.scan ./.;

  home.username = lib.mkDefault "tsln";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "25.11";
}
