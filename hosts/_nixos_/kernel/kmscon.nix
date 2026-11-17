{ pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    package = pkgs.kmscon;

    config = {
      hwaccel = true;
      font-size = 12;
      font-dpi = 144;
    };
  };
}
