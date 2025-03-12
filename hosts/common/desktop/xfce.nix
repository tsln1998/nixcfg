{ lib, ... }:
{
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableScreensaver = lib.mkDefault false;
  };
}
