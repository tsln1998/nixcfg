_: final: prev:
let
  gnused = final.gnused;
in
{
  feishu = prev.feishu.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      ${final.lib.getExe gnused} -i \
        's/^Categories=.*/Categories=Network;/' \
        "$out/share/applications/bytedance-feishu.desktop"
    '';
  });

  hoppscotch = prev.hoppscotch.override {
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
  };

  unstable = prev.unstable // {
    qq = prev.unstable.qq.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        ${final.lib.getExe gnused} -i \
          's/^Comment=.*/Comment=QQ for Linux;/' \
          "$out/share/applications/qq.desktop"
      '';
    });
  };

  nur = prev.nur // {
    repos = prev.nur.repos // {
      xddxdd = prev.nur.repos.xddxdd // {
        wechat-uos-sandboxed = prev.nur.repos.xddxdd.wechat-uos-sandboxed.override {
          buildFHSEnvBubblewrap =
            args:
            final.buildFHSEnvBubblewrap (
              args
              // {
                extraInstallCommands = (args.extraInstallCommands or "") + ''
                  ${final.lib.getExe gnused} -i \
                    's/^Categories=.*/Categories=Network;/' \
                    "$out/share/applications/com.tencent.wechat.desktop"
                '';
              }
            );
        };
      };
    };
  };
}
