{ pkgs,lib, ... }:
{
  home.packages = [
    (pkgs.hoppscotch.override {
      appimageTools = pkgs.appimageTools // {
        wrapType2 = args:
          pkgs.appimageTools.wrapType2 (args // {
            extraInstallCommands =
              (args.extraInstallCommands or "")
              + ''
                ${lib.getExe pkgs.gnused} -i \
                  's/^Categories=.*/Categories=Development;/' \
                  "$out/share/applications/hoppscotch.desktop"
              '';
          });
      };
    })
  ];
}
