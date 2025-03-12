{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/desktop/xfce.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/xrdp.nix"
      "hosts/common/services/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "24.11";
}
