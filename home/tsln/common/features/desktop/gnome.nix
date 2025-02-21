{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    system-monitor
    windownavigator
    workspace-indicator
    dynamic-panel
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
    };
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        workspace-indicator.extensionUuid
        windownavigator.extensionUuid
        system-monitor.extensionUuid
        dynamic-panel.extensionUuid
      ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      action-double-click-titlebar = "toggle-maximize";
      action-middle-click-titlebar = "none";
      action-right-click-titlebar = "menu";
    };
    "org/gnome/Console" = {
      theme = "auto";
      use-system-font = false;
      custom-font = "FiraCode Nerd Font 10";
    };
    "org/gnome/shell/extensions/dynamic-panel" = {
      top-margin = 8;
      blur = false;
      transparent = 10;
      transparent-menus = false;
      background-mode = 1;
    };
  };
}
