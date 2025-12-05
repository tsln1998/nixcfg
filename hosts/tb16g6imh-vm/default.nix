{ tools, ... }:
{
  imports = (
    map tools.relative [
      "<disko>"
      "hosts/common/global"
      "hosts/common/services/openssh.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
