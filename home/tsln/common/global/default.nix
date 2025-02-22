{ config,tools, ... }:
{
  imports = tools.scan ./.;

  # systemd.user.startServices = "sd-switch";

  home.username = "tsln";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "24.11";
}
