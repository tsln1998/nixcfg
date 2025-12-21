{ lib, ... }:
{
  services.xserver.enable = lib.mkDefault true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.enable = false;
    greeters.pantheon.enable = true;
  };
}
