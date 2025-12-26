{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    input = {
      keyboard = {
        numlockOnStartup = "on";
      };
    };
    configFile = {
      kwinrc = {
        Desktops = {
          Number = 4;
          Rows = 2;
        };
        TabBox = {
          LayoutName = "flipswitch";
        };
      };
      ksmserverrc = {
        General = {
          loginMode = "emptySession";
        };
      };
    };
  };

  xdg.portal = {
    enable = true;

    extraPortals =
      with pkgs;
      with kdePackages;
      [
        xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];

    config = {
      common = {
        default = [ "kde" ];
      };

      kde = {
        default = [ "kde" ];
      };
    };
  };
}
