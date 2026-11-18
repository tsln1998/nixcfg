{ config, lib, ... }:
let
  # Application modules set the order of pinned launchers with lib.mkOrder.
  inherit (config.programs.plasma.launchers) icontasks kickoff;
in
{
  programs.plasma.panels = [
    {
      # Full-width floating panel at the bottom of the screen.
      alignment = "center";
      floating = true;
      height = 36;
      offset = 0;
      hiding = "none";
      lengthMode = "fill";
      location = "bottom";
      opacity = "adaptive";

      # Widgets appear from left to right in the order listed here.
      widgets = [
        # Application menu with session and power actions.
        {
          name = "org.kde.plasma.kickoff";
          config = {
            popupHeight = 650;
            popupWidth = 750;
            General = {
              favorites = kickoff;
              icon = "distributor-logo-nixos";
              alphaSort = true;
              showRecentApps = false;
              showRecentDocs = false;
              favoritesPortedToKAstats = false;
              systemFavorites = lib.strings.concatStringsSep "\\," [
                "suspend"
                "hibernate"
                "reboot"
                "shutdown"
              ];
            };
          };
        }

        # Switch between virtual desktops.
        {
          name = "org.kde.plasma.pager";
        }

        # Show pinned apps and running windows as icons.
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General = {
              launchers = icontasks;
              showOnlyCurrentActivity = false;
              showOnlyCurrentDesktop = false;
              showOnlyCurrentScreen = false;
              showOnlyMinimized = false;
            };
          };
        }

        # Separate the task icons from the window list.
        {
          name = "org.kde.plasma.marginsseparator";
        }

        # Open the window list on hover.
        {
          name = "org.kde.plasma.windowlist";
          config = {
            General = {
              openOnHover = true;
              showText = false;

              showOnlyCurrentActivity = false;
              showOnlyCurrentDesktop = false;
              showOnlyCurrentScreen = false;
              showOnlyMinimized = false;
            };
          };
        }

        # Plot physical memory usage.
        {
          name = "org.kde.plasma.systemmonitor";
          config = {
            CurrentPreset = "org.kde.plasma.systemmonitor";
            popupHeight = 400;
            popupWidth = 400;
            Appearance = {
              chartFace = "org.kde.ksysguard.linechart";
              title = "RAM";
              updateRateLimit = 0;
            };
            Sensors = {
              highPrioritySensorIds = lib.toJSON [
                "memory/physical/used"
              ];
              lowPrioritySensorIds = lib.toJSON [
                "memory/physical/total"
              ];
              totalSensors = lib.toJSON [
                "memory/physical/usedPercent"
              ];
            };
          };
        }

        # Plot overall CPU usage.
        {
          name = "org.kde.plasma.systemmonitor";
          config = {
            CurrentPreset = "org.kde.plasma.systemmonitor";
            popupHeight = 400;
            popupWidth = 400;
            Appearance = {
              chartFace = "org.kde.ksysguard.linechart";
              title = "CPU";
              updateRateLimit = 1000;
            };
            Sensors = {
              highPrioritySensorIds = lib.toJSON [
                "cpu/all/usage"
              ];
              lowPrioritySensorIds = lib.toJSON [
                "cpu/all/cpuCount"
                "cpu/all/coreCount"
              ];
              totalSensors = lib.toJSON [
                "cpu/all/usage"
              ];
            };
          };
        }

        # Separate system monitors from the tray, clock, and Show Desktop button.
        {
          name = "org.kde.plasma.marginsseparator";
        }

        # Host system status icons and background app controls.
        {
          name = "org.kde.plasma.systemtray";
          config = {
            popupHeight = 450;
            popupWidth = 430;
            General = {
              iconSpacing = 1;
            };
          };
        }

        # Display the time and open the calendar when clicked.
        {
          name = "org.kde.plasma.digitalclock";
          config = {
            popupHeight = 450;
            popupWidth = 450;
          };
        }

        # Toggle the desktop view.
        {
          name = "org.kde.plasma.showdesktop";
        }
      ];
    }
  ];
}
