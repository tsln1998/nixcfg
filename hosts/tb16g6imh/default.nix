{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/_common/global"
      "hosts/_common/i18n"
      "hosts/_common/display/sddm.nix"
      "hosts/_common/desktop/plasma.nix"
      "hosts/_common/services/plymouth.nix"
      "hosts/_common/services/openssh.nix"
      "hosts/_common/services/docker.nix"
      "hosts/_common/services/kmscon.nix"
      "hosts/_common/themes/catppuccin.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
