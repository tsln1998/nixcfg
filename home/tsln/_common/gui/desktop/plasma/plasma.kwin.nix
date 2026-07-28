{
  programs.plasma.configFile = {
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
        BorderSnapZone=10;
        WindowSnapZone=10;
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
}
