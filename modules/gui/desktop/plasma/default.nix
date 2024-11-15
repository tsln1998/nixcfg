{ pkgs, ... }:
{
  services.desktopManager.plasma6 = {
    enable = true;
    notoPackage = pkgs.noto-fonts-cjk;
  };

  environment.plasma6 = {
    excludePackages = with pkgs.kdePackages; [ plasma-browser-integration ];
  };
}
