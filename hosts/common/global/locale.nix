{ lib, ... }:
{
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
    ];
  };

  time.timeZone = lib.mkDefault "Asia/Hong_Kong";
  time.hardwareClockInLocalTime = true;

  location.provider = "geoclue2";
}
