{ pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "zh-CN"
      "zh-TW"
    ];

    profiles = {
      default = {
        extensions = {
          packages = with pkgs.firefox-addons; [
            ubolite # uBlock Origin Lite
            bitwarden # Bitwarden
            hoppscotch # Hoppscotch
            elasticvue # Elasticvue
          ];
        };
      };
    };
  };

  programs.plasma.launchers = {
    icontasks = lib.mkOrder 20 [ "applications:firefox.desktop" ];
    kickoff = lib.mkOrder 20 [ "firefox.desktop" ];
  };
}
