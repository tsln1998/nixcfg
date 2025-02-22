{ pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.mutter ];
    desktopManager.gnome.extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
    '';
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-characters
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-weather
    gnome-tour
    gnome-shell-extensions
    nixos-render-docs
    yelp
    geary
    seahorse
    totem
    epiphany
    simple-scan
  ];
}
