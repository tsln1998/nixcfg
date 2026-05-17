{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/gui/desktop/plasma.nix"
      "hosts/_common/gui/display/sddm.nix"
      "hosts/_common/i18n"
      "hosts/_common/themes"
      "hosts/_common/kernel/kmscon.nix"
      "hosts/_common/kernel/plymouth.nix"
      "hosts/_common/services/openssh.nix"
      "hosts/_common/virtualisation/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
