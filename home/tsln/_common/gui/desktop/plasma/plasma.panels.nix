{
  programs.plasma.panels = [
    {
      alignment = "center";
      floating = true;
      height = 34;
      hiding = "none";
      lengthMode = "fill";
      location = "bottom";
      offset = 0;
      opacity = "adaptive";
      widgets = [
        {
          name = "org.kde.plasma.kickoff";
          config = {
            popupHeight = 680;
            popupWidth = 730;
            General = {
              alphaSort = true;
              favoritesPortedToKAstats = true;
              icon = "distributor-logo-nixos";
              showRecentApps = false;
              showRecentDocs = false;
              systemFavorites = "suspend\\,hibernate\\,reboot\\,shutdown";
            };
          };
        }
        "org.kde.plasma.pager"
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General.launchers = [ "preferred://filemanager" ];
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          name = "org.kde.plasma.windowlist";
          config = {
            popupHeight = 400;
            popupWidth = 560;
            General = {
              openOnHover = true;
              showOnlyCurrentActivity = false;
              showOnlyCurrentDesktop = false;
              showText = false;
            };
          };
        }
        {
          name = "org.kde.plasma.systemmonitor";
          config = {
            CurrentPreset = "org.kde.plasma.systemmonitor";
            popupHeight = 400;
            popupWidth = 560;
            Appearance = {
              chartFace = "org.kde.ksysguard.linechart";
              title = "RAM";
              updateRateLimit = 0;
            };
            Sensors = {
              highPrioritySensorIds = ''["memory/physical/used"]'';
              lowPrioritySensorIds = ''["memory/physical/total"]'';
              totalSensors = ''["memory/physical/usedPercent"]'';
            };
          };
        }
        {
          name = "org.kde.plasma.systemmonitor";
          config = {
            CurrentPreset = "org.kde.plasma.systemmonitor";
            popupHeight = 400;
            popupWidth = 560;
            Appearance = {
              chartFace = "org.kde.ksysguard.linechart";
              title = "CPU";
              updateRateLimit = 1000;
            };
            Sensors = {
              highPrioritySensorIds = ''["cpu/all/usage"]'';
              lowPrioritySensorIds = ''["cpu/all/cpuCount","cpu/all/coreCount"]'';
              totalSensors = ''["cpu/all/usage"]'';
            };
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          name = "org.kde.plasma.systemtray";
          config = {
            popupHeight = 432;
            popupWidth = 432;
            General = {
              extraItems = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.notifications"
                "org.kde.plasma.mediacontroller"
                "org.kde.kscreen"
                "org.kde.plasma.volume"
                "org.kde.plasma.brightness"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.battery"
              ];
              hiddenItems = [
                "chrome_status_icon_1"
                "lark_status_icon_1"
              ];
              iconSpacing = 1;
              knownItems = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.cameraindicator"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.notifications"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.weather"
                "org.kde.kscreen"
                "org.kde.plasma.volume"
                "org.kde.plasma.brightness"
                "org.kde.plasma.battery"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.keyboardindicator"
              ];
            };
          };
        }
        {
          name = "org.kde.plasma.digitalclock";
          config = {
            popupHeight = 451;
            popupWidth = 560;
            Appearance.fontWeight = 400;
          };
        }
        "org.kde.plasma.showdesktop"
      ];
    }
  ];
}
