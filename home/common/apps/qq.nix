{ pkgs, ... }:
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "qq-with-fcitx5";
      paths = [ pkgs.qq ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/qq \
          --set QT_IM_MODULE fcitx \
          --set XMODIFIERS "@im=fcitx" \
          --set GTK_IM_MODULE fcitx \
          --set ELECTRON_OZONE_PLATFORM_HINT auto
      '';
    })
  ];
}
