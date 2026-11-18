{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override {
      enableWideVine = true;
    };
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "djnlaiohfaaifbibleebjggkghlmcpcj"; } # FluentRead
      { id = "eggdlmopfankeonchoflhfoglaakobma"; } # Apifox
      { id = "amknoiejhlmhancpahfcfcfhllgkpbld"; } # Hoppscotch
      { id = "hkedbapjpblbodpgbajblpnlpenaebaa"; } # Elasticvue
    ];
  };

  home.sessionVariables = {
    CHROME_EXECUTABLE = "${config.programs.chromium.package}/bin/chromium";
  };

  programs.plasma.launchers = {
    icontasks = lib.mkOrder 10 [ "applications:chromium-browser.desktop" ];
    kickoff = lib.mkOrder 10 [ "chromium-browser.desktop" ];
  };
}
