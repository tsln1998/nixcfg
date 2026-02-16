{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 2;
        output = [
          "eDP-1"
        ];

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
        ];

        # Workspaces
        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        # Submap (keybind mode indicator)
        "hyprland/submap" = {
          format = "<span style=\"italic\">  {}</span>";
          max-length = 8;
          tooltip = false;
        };

        # Window title
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        # System tray
        tray = {
          icon-size = 16;
          spacing = 10;
        };

        # Clock
        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        # CPU
        cpu = {
          format = " {usage}%";
          tooltip = false;
          interval = 2;
        };

        # Memory
        memory = {
          format = " {}%";
          interval = 5;
        };

        # Temperature
        temperature = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["" "" ""];
        };

        # Battery
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
        };

        # Network
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ipaddr}";
          format-linked = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = " {essid} ({signalStrength}%)";
        };

        # Audio
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        # Backlight
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
      };
    };

    # Styling - extends catppuccin theme
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Jetbrains Mono";
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: alpha(@surface0, 0.5);
        border-bottom: 1px solid alpha(@lavender, 0.2);
        box-shadow: 0 2px 10px alpha(@sky, 0.3);
      }

      #workspaces button {
        padding: 0 8px;
      }

      #workspaces button.active {
        border-bottom: 2px solid @blue;
      }

      #workspaces button.urgent {
        border-bottom: 2px solid @red;
      }

      #submap {
        padding: 0 10px;
        color: @yellow;
        background: rgba(249, 226, 175, 0.1);
      }

      #window {
        padding: 0 10px;
      }

      #clock,
      #battery,
      #backlight,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        margin: 0 2px;
      }

      #tray {
        opacity: 0.6;
      }
      
      #tray:hover {
        opacity: 1.0;
      }

      #battery.warning:not(.charging) {
        color: @yellow;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }

      #temperature.critical {
        color: @red;
      }

      #network.disconnected {
        color: @red;
      }

      #pulseaudio.muted {
        color: @overlay0;
      }
    '';
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
    ];
  };
}
