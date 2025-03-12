{ config, lib, ... }:
let
  dm = config.services.xserver.desktopManager;
in
{
  services.xrdp.enable = true;
  services.xrdp.openFirewall = lib.mkDefault true;
  services.xrdp.defaultWindowManager = lib.mkDefault (
    if dm.xfce.enable then
      "xfce4-session"
    else if dm.lxqt.enable then
      "lxqt-session"
    else
      abort "no window manager installed"
  );
}
