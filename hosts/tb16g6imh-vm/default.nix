{ tools, ... }:
{
  imports = (
    map tools.relative [
      "<disko>"
      "hosts/common/global"
      # "hosts/common/desktop/gdm.nix"
      # "hosts/common/desktop/gnome.nix"
      "hosts/common/desktop/sddm.nix"
      "hosts/common/desktop/plasma.nix"
      "hosts/common/services/comin.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/plymouth.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.05";
}
