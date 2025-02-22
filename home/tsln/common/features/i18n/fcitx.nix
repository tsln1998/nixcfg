{ pkgs, ... }:
let
  addons = [
    pkgs.fcitx5-chinese-addons
  ];

  fcitx5 = pkgs.fcitx5-with-addons.override {
    inherit addons;
  };

  kimpanel = pkgs.gnomeExtensions.kimpanel;
in
{
  home.packages = [
    fcitx5
    kimpanel
  ];

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    QT_IM_MODULES = "wayland;fcitx";
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = ''gtk-im-module="fcitx"'';
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/xsettings" = {
      overrides = "{'Gtk/IMModule':<'fcitx'>}";
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        kimpanel.extensionUuid
      ];
    };
  };

  systemd.user.services.fcitx5-daemon = {
    Unit = {
      Description = "Fcitx5 input method editor";
      PartOf = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${fcitx5}/bin/fcitx5";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
