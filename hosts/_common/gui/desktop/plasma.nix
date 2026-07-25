{ pkgs, ... }:
with pkgs;
with kdePackages;
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  environment.plasma6.excludePackages = [
    kate
    elisa
    okular
    discover
    gwenview
    khelpcenter
    plasma-browser-integration
  ];
}
