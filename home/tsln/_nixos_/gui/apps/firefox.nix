{ pkgs, ... }:
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
}
