{ lib, ... }:
{
  time.timeZone = lib.mkDefault "Asia/Hong_Kong";
  time.hardwareClockInLocalTime = lib.mkDefault true;
}
