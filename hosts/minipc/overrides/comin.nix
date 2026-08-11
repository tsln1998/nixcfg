{ lib, ... }: {
  services.comin.remotes = lib.mkForce [
    {
      name = "origin";
      url = "https://github.com/tsln1998/nixcfg.git";
      branches = {
        main = {
          # 这台机器不自动部署，只接受 testing 更新；用于远程紧急救援。
          name = "DONT_PULL_ANY_BRANCH";
        };
      };
    }
  ];
  services.comin.postDeploymentCommand = lib.mkForce null;
}
