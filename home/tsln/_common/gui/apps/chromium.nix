{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override {
      enableWideVine = true;
    };
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh"; } # Translator
      { id = "eggdlmopfankeonchoflhfoglaakobma"; } # Apifox
      { id = "amknoiejhlmhancpahfcfcfhllgkpbld"; } # Hoppscotch
      { id = "hkedbapjpblbodpgbajblpnlpenaebaa"; } # Elasticvue
    ];
  };
}
