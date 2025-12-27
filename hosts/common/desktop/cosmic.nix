{ pkgs, ... }:
{
  services.desktopManager.cosmic = {
    enable = true;
    showExcludedPkgsWarning = false;
  };

  environment.cosmic.excludePackages = [
    pkgs.cosmic-initial-setup
  ];
}
