{
  lib,
  fetchzip,
  appimageTools,
  makeDesktopItem,
  ...
}:
let
  pname = "apifox";
  version = "2.5.19";
  name = "${pname}-${version}";
  hash = "sha256-+TlJoLkmNED7QG3Nya8k4sDaFSH0E6izm1Ex7HXZ9hY=";

  src = fetchzip {
    url = "https://cdn.apifox.com/download/Apifox-linux-latest.zip";
    stripRoot = false;
    inherit hash;
  };
  appimage-file = "${src}/Apifox.AppImage";

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "ApiFox";
    exec = pname;
    icon = "apifox";
    categories = [
      "Network"
      "Development"
    ];
  };

  appimageContents = appimageTools.extractType2 {
    inherit name;
    src = appimage-file;
  };
in
appimageTools.wrapType2 rec {
  inherit name;

  src = appimage-file;

  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;

  extraInstallCommands = ''
    mv $out/bin/{${name},${pname}}
    mkdir -p $out/share
    cp -rt $out/share ${desktopItem}/share/applications ${appimageContents}/usr/share/icons
    chmod -R +w $out/share
  '';

  meta = {
    description = "ApiFox";
    homepage = "https://apifox.com";
    license = lib.licenses.unfree;
    maintainers = with lib.stdenv.lib.maintainers; [ mslxl ];
    platforms = [ "x86_64-linux" ];
  };
}
