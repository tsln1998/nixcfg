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
    };
    ksmserverrc = {
      General = {
        loginMode = "emptySession";
      };
    };
  };
}
