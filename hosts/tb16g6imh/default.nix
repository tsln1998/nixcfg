{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/desktop/plasma.nix"
      "hosts/common/desktop/sddm.nix"
      "hosts/common/services/plymouth.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/themes/catppuccin.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
