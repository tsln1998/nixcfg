{ pkgs, ... }:
with pkgs;
with kdePackages;
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  xdg.portal = {
    enable = true;

    extraPortals = [
      xdg-desktop-portal-kde
    ];
  };

  environment.defaultPackages = [
    qtbase
    xdg-utils
    desktop-file-utils
  ];

  environment.plasma6.excludePackages = [
    plasma-browser-integration
    khelpcenter
    kate
    elisa
    okular
  ];
}
