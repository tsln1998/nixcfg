{ config, pkgs, ... }:
{
  home.packages =
    with pkgs;
    with gnomeExtensions;
    [
      numix-icon-theme-circle

      system-monitor
      windownavigator
      workspace-indicator
      dynamic-panel
    ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  dconf.settings = {
    "org/gnome/shell" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];
      enabled-extensions = with pkgs.gnomeExtensions; [
        workspace-indicator.extensionUuid
        windownavigator.extensionUuid
        system-monitor.extensionUuid
        dynamic-panel.extensionUuid
      ];
      favorite-apps = (
        (if config.programs.chromium.enable then [ "chromium-browser.desktop" ] else [ ])
        ++ (if config.programs.firefox.enable then [ "firefox.desktop" ] else [ ])
        ++ [
          "org.gnome.Nautilus.desktop"
          "org.gnome.SystemMonitor.desktop"
          "org.gnome.Console.desktop"
        ]
      );
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Alt>a" ];
      move-to-workspace-right = [ "<Shift><Alt>Right" ];
      move-to-workspace-left = [ "<Shift><Alt>Left" ];
      move-to-monitor-right = [ "<Shift><Super>Left" ];
      move-to-monitor-left = [ "<Shift><Super>Left" ];
      switch-to-workspace-right = [ "<Super>End" ];
      switch-to-workspace-left = [ "<Super>Home" ];
    };
    "org/gnome/desktop/interface" = {
      icon-theme = "Numix-Circle";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      action-double-click-titlebar = "toggle-maximize";
      action-middle-click-titlebar = "none";
      action-right-click-titlebar = "menu";
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
      remember-numlock-state = false;
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
