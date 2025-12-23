{ pkgs, ... }:
{
  home.packages = [
    pkgs.brightnessctl
    pkgs.wireplumber
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      outputs = {
        eDP-1 = {
          scale = 1.5;
        };
      };
      spawn-at-startup = [
        { argv = [ "fcitx" ]; }
        { argv = [ "waybar" ]; }
      ];
      binds = {
        # Launcher
        "Mod+R".action.spawn = "fuzzel";
        "Mod+L".action.spawn = "hyprlock";

        # Function Keys
        XF86MonBrightnessUp.action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "5%+"
        ];
        XF86MonBrightnessDown.action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "5%-"
        ];
        XF86AudioRaiseVolume.action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1+"
        ];
        XF86AudioLowerVolume.action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1-"
        ];
        XF86AudioMute.action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        XF86AudioMicMute.action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];

        # Window Manager
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+Up".action.focus-window-or-workspace-up = [ ];
        "Mod+Right".action.focus-column-right = [ ];

        # Window Control
        "Mod+Ctrl+Left".action.move-column-left = [ ];
        "Mod+Ctrl+Down".action.move-workspace-down = [ ];
        "Mod+Ctrl+Up".action.move-workspace-up = [ ];
        "Mod+Ctrl+Right".action.move-column-right = [ ];
        "Mod+Shift+Down".action.move-window-down = [ ];
        "Mod+Shift+Up".action.move-window-up = [ ];

        # Window Mouse Control
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+WheelScrollDown".action.focus-window-or-workspace-down = [ ];
        "Mod+WheelScrollUp".action.focus-window-or-workspace-up = [ ];
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];

        # Window Resize
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Overview
        "Mod+Tab".action.toggle-overview = [ ];

        # Center
        "Mod+C".action.center-column = [ ];

        # Fullscreen
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];

        # Quit
        "Ctrl+Alt+Delete".action.quit = [ ];
      };
    };
  };

  programs.fuzzel = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 35;
        modules-left = [
          "clock"
          "cpu"
          "temperature"
          "memory"
          "load"
        ];
        modules-center = [
          "tray"
        ];
        modules-right = [
          "network"
          "wireplumber"
          "backlight"
          "battery"
        ];
        clock = {
          format = "{:%H:%M %m/%d}";
        };
      };
    };
  };
}
