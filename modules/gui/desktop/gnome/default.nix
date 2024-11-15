{ lib, pkgs,... }:
{
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  environment.gnome.excludePackages = [
    pkgs.snapshot
    pkgs.gnome-console
    pkgs.gnome.epiphany
    pkgs.gnome.yelp
    pkgs.gnome.simple-scan
    pkgs.gnome.gnome-contacts
    pkgs.gnome.gnome-weather
    pkgs.gnome.gnome-maps
    pkgs.gnome.gnome-music
  ];
}
