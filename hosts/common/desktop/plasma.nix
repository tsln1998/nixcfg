{ pkgs, ... }:
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk-sans;
  };

  environment.plasma6.excludePackages = with pkgs; [
    plasma-browser-integration
    gwenview
    khelpcenter
    elisa
    okular
    kate
  ];
}
