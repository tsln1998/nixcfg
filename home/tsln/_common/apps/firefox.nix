{ pkgs, lib, ... }:
{
  programs.firefox = rec {
    enable = true;
    package = pkgs.unstable.firefox;
    languagePacks = [
      "zh_CN"
      "en_US"
    ];
    profiles = {
      default = {
        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            hoppscotch
          ];
        };

        settings = {
          "browser.search.region" = "US";

          "browser.urlbar.placeholderName" = "Google";
          "browser.urlbar.placeholderName.private" = "Google";

          "browser.newtabpage.activity-stream.showSearch" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.newtabpage.activity-stream.system.showWeatherOptIn" = false;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;

          "browser.ai.control.default" = "blocked";
          "browser.ai.control.linkPreviewKeyPoints" = "blocked";
          "browser.ai.control.pdfjsAltText" = "blocked";
          "browser.ai.control.sidebarChatbot" = "blocked";
          "browser.ai.control.smartTabGroups" = "blocked";
          "browser.ai.control.translations" = "blocked";
          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.page" = false;
          "browser.ml.linkPreview.enabled" = false;
          "signon.rememberSignons" = false;

          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.addresses.enabled" = false;

          "intl.locale.requested" = lib.concatStringsSep "," languagePacks;
        };
      };
    };
  };
}
