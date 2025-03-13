{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/desktop/plasma.nix"
      "hosts/common/services/xrdp.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/bbr.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "24.11";
}
