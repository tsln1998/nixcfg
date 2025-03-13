{
  config,
  lib,
  ...
}:
let
  dm  = config.services.xserver.desktopManager;
  dm' = config.services.desktopManager;
in
{
  services.xrdp.enable = true;
  services.xrdp.openFirewall = lib.mkDefault true;

  services.xrdp.defaultWindowManager = lib.mkDefault (
    if dm'.plasma6.enable then
      "startplasma-x11"
    else if dm.xfce.enable then
      "xfce4-session"
    else if dm.lxqt.enable then
      "startlxqt"
    else
      abort "no window manager installed"
  );
}
