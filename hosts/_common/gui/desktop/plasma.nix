{ pkgs, ... }:
with pkgs;
with kdePackages;
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  environment.plasma6.excludePackages = [
    qrca
    elisa
    discover
    khelpcenter
    plasma-browser-integration
    plasma-workspace-wallpapers
  ];

  environment.systemPackages = [
    partitionmanager
    kalk
  ];
}
