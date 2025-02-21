{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.chromium;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh"; } # Translator
      { id = "eggdlmopfankeonchoflhfoglaakobma"; } # Apifox
      { id = "amknoiejhlmhancpahfcfcfhllgkpbld"; } # Hoppscotch
    ];
  };
}
