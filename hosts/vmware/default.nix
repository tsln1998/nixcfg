{ tools, ... }:
{
  imports = (
    map tools.relative [
      "<disko>"
      "hosts/common/global"
      "hosts/common/features/desktop/gnome.nix"
      "hosts/common/features/services/openssh.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "24.11";
}
