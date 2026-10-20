{
  programs = {
    plasma = {
      configFile = {
        kwinrc = {
          Desktops = {
            Number = 4;
            Rows = 2;
          };
          TabBox = {
            LayoutName = "sidebar";
          };
          Windows = {
            RollOverDesktops = true;
            BorderSnapZone = 10;
            WindowSnapZone = 10;
          };
          Script-desktopchangeosd = {
            PopupHideDelay = 500;
          };
        };
        ksmserverrc = {
          General = {
            loginMode = "emptySession";
          };
        };
      };

      window-rules = [
        {
          description = "Alacritty 的窗口设置";
          match = {
            window-class = {
              value = "Alacritty";
              type = "substring";
              match-whole = true;
            };
            window-types = [ "normal" ];
          };
          apply = {
            decocolor = {
              value = "BreezeDark";
              apply = "force";
            };
          };
        }
      ];
    };
  };
}
