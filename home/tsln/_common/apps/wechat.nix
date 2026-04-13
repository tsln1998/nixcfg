{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.nur.repos.xddxdd.wechat-uos-sandboxed.override {
      buildFHSEnvBubblewrap =
        args:
        pkgs.buildFHSEnvBubblewrap (
          args
          // {
            extraInstallCommands = (args.extraInstallCommands or "") + ''
              ${lib.getExe pkgs.gnused} -i \
                's/^Categories=.*/Categories=Network;/' \
                "$out/share/applications/com.tencent.wechat.desktop"
            '';
          }
        );
    })
  ];
}
