_: final: prev:
let
  gnused = final.gnused;

  mkNixpkgsOverrided =
    pkgs:
    pkgs
    // {
      feishu = pkgs.feishu.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          ${final.lib.getExe gnused} -i \
            's/^Categories=.*/Categories=Network;/' \
            "$out/share/applications/bytedance-feishu.desktop"
        '';
      });

      hoppscotch = pkgs.hoppscotch.override {
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

      qq = pkgs.qq.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          ${final.lib.getExe gnused} -i \
            's/^Comment=.*/Comment=QQ for Linux/' \
            "$out/share/applications/qq.desktop"
        '';
      });
    };

  mkNurOverrided =
    nur:
    nur
    // {
      repos = nur.repos // {
        xddxdd = nur.repos.xddxdd // {
          wechat-uos-sandboxed = nur.repos.xddxdd.wechat-uos-sandboxed.override {
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
in
mkNixpkgsOverrided prev
// {
  unstable = mkNixpkgsOverrided prev.unstable;
  nur = mkNurOverrided prev.nur;
}
