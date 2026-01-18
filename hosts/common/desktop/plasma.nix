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
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "kde" ];
      };

      kde = {
        default = [ "kde" ];
      };
    };
  };

  environment.defaultPackages = [
    partitionmanager
  ];

  environment.plasma6.excludePackages = [
    plasma-browser-integration
    khelpcenter
    kate
    elisa
  ];
}
