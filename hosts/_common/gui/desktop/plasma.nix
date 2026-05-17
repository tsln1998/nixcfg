{ pkgs, ... }:
with pkgs;
with kdePackages;
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  environment.systemPackages = [
    partitionmanager
  ];

  environment.plasma6.excludePackages = [
    plasma-browser-integration
    khelpcenter
    kate
    elisa
    discover
  ];
}
