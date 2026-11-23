_: {
  programs.google-chrome = {
    enable = true;
    package = null;
    extensions = [
      { id = "hehggadaopoacecdllhhajmbjkdcmajg"; } # ChatGPT
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "djnlaiohfaaifbibleebjggkghlmcpcj"; } # FluentRead
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
    ];
  };
}
