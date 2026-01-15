{ tools, ... }:
{
  imports = [
    (tools.relative "home/common/apps/chromium.nix")
  ];

  programs.chromium = {
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
