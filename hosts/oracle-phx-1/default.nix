{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/services/comin.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/bbr.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.05";
}
