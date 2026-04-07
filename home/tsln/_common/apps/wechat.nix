{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.repos.nur.xddxdd.wechat-uos-sandboxed.override {
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
