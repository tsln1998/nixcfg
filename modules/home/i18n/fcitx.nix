{lib, config, ...}: {
  config = lib.mkIf config.i18n.inputMethod.fcitx5.waylandFrontend {
    home.sessionVariables = {
      NIXOS_OZONE_WL=1;
    };
  };
}