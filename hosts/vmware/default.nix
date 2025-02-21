{ tools, ... }:
{
  imports = (
    map tools.relative [
      "<disko>"
      "hosts/common/global"
      "hosts/common/desktop/gnome.nix"
      "hosts/common/services/openssh.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "24.11";
}
