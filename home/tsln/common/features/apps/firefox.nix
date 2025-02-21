{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    languagePacks = [
      "en-US"
      "zh-CN"
    ];
    profiles.primary = {
      name = "Default Profile";
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        hoppscotch
      ];
    };
  };
}
