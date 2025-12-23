{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/i18n"
      "hosts/common/display/sddm.nix"
      "hosts/common/desktop/plasma.nix"
      "hosts/common/desktop/niri.nix"
      "hosts/common/services/plymouth.nix"
      "hosts/common/services/openssh.nix"
      "hosts/common/themes/catppuccin.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
