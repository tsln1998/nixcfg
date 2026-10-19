{ lib, ... }: {
  services.comin = {
    # 这台机器不自动部署，只接受 testing 更新；用于远程紧急救援。
    remotes = lib.mkForce [
      {
        name = "origin";
        url = "https://github.com/tsln1998/nixcfg.git";
        branches = {
          main = {
            name = "DONT_PULL_ANY_BRANCH";
          };
        };
      }
    ];
  };
}
