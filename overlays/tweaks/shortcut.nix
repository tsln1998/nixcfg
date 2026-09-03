{ lib, ... }:
final: prev:
let
  gnused = final.gnused;
in
{
  feishu = prev.feishu.overrideAttrs (
    old:
    (lib.optionalAttrs prev.stdenv.isLinux {
      postFixup = (old.postFixup or "") + ''
        ${final.lib.getExe gnused} -i \
          's/^Categories=.*/Categories=Network;/' \
          "$out/share/applications/bytedance-feishu.desktop"
      '';
    })
  );

  hoppscotch = prev.hoppscotch.override (
    lib.optionalAttrs prev.stdenv.isLinux {
      appimageTools = final.appimageTools // {
        wrapType2 =
          args:
          final.appimageTools.wrapType2 (
            args
            // {
              extraInstallCommands = (args.extraInstallCommands or "") + ''
                ${final.lib.getExe gnused} -i \
                  's/^Categories=.*/Categories=Development;/' \
                  "$out/share/applications/hoppscotch.desktop"
              '';
            }
          );
      };
    }
  );

  qq = prev.qq.overrideAttrs (
    old:
    (lib.optionalAttrs prev.stdenv.isLinux {
      postFixup = (old.postFixup or "") + ''
        ${final.lib.getExe gnused} -i \
          's/^Comment=.*/Comment=QQ for Linux/' \
          "$out/share/applications/qq.desktop"
      '';
    })
  );

  wechat = prev.wechat.overrideAttrs (
    old:
    (lib.optionalAttrs prev.stdenv.isLinux {
      buildCommand = (old.buildCommand or "") + ''
        ${final.lib.getExe gnused} -i \
          's/^Categories=.*/Categories=Network;/' \
          "$out/share/applications/wechat.desktop"
      '';
    })
  );
}
