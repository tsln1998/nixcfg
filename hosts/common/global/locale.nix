{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "zh_CN.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
  };
  location.provider = "geoclue2";
  time.timeZone = lib.mkDefault "Asia/Hong_Kong";
  time.hardwareClockInLocalTime = true;
}
