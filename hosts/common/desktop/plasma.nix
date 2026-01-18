{ pkgs, ... }:
with pkgs;
with kdePackages;
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
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
