{
  lib,
  pkgs,
  config,
  ...
}:
{
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  i18n.supportedLocales = lib.mkDefault [
    "en_US.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
  ];
  i18n.glibcLocales = pkgs.glibcLocales.override {
    allLocales = false;
    locales = config.i18n.supportedLocales;
  };
}
