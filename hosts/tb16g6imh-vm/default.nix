{ tools, ... }:
{
  imports = (
    map tools.relative [
      "<disko>"
      "hosts/common/global"
      "hosts/common/desktop/plasma.nix"
      "hosts/common/desktop/sddm.nix"
      "hosts/common/services/plymouth.nix"
      "hosts/common/services/openssh.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
