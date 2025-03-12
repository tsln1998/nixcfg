{
  config,
  pkgs,
  lib,
  ...
}:
let
  addons = [
    pkgs.fcitx5-chinese-addons
  ];

  fcitx5 = pkgs.fcitx5-with-addons.override {
    inherit addons;
  };
in
{
  # enable fcitx
  home.packages = [
    fcitx5
  ];

  # fcitx daemon
  systemd.user.services.fcitx5-daemon = {
    Unit = {
      Description = "Fcitx5 input method editor";
      PartOf = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${fcitx5}/bin/fcitx5";
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # fcitx qt
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
  };

  # fcitx gtk
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

  # fcitx plasma virtual keyboard
  programs.plasma.configFile = lib.optionalAttrs config.programs.plasma.enable {
    "kwinrc"."Wayland"."InputMethod[$e]" =
      "$HOME/.nix-profile/share/applications/fcitx5-wayland-launcher.desktop";
    "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;
  };
}
