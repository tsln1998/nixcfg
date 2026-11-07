{ pkgs, ... }:
{
  programs.google-chrome = {
    enable = true;
    package = pkgs.google-chrome;
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh"; } # Translator
    ];
  };
}
