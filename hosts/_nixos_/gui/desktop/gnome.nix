{ pkgs, ... }:
{
  services.desktopManager.gnome = {
    enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    gnome-calendar
    gnome-contacts
    gnome-browser-connector
    gnome-characters
    gnome-connections
    gnome-font-viewer
    gnome-initial-setup
    gnome-online-accounts
    gnome-weather
    gnome-maps
    showtime
    epiphany
    geary
    yelp
  ];
}
