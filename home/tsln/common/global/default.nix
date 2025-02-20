{ tools, ... }:
{
  imports = tools.scan ./.;

  systemd.user.startServices = "sd-switch";

  home.username = "tsln";
  home.homeDirectory = "/home/tsln";
  home.stateVersion = "24.11";
}
