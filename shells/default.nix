pkgs:
let
  inherit (pkgs) lib;
  inherit (pkgs.stdenv) hostPlatform;
in
{
  default = import ./default pkgs;
  android = import ./android pkgs;
  network = import ./network pkgs;
}
// lib.optionalAttrs hostPlatform.isLinux {
  hardware = import ./hardware pkgs;
  openwrt = import ./openwrt pkgs;
  aircrack = import ./aircrack pkgs;
}
// lib.optionalAttrs (hostPlatform.isLinux && hostPlatform.isx86_64) {
  uup = import ./uup pkgs;
}
