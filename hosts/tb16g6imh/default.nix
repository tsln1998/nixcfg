{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/boot/kmscon.nix"
      "hosts/_common/boot/plymouth.nix"
      "hosts/_common/gui/desktop/plasma.nix"
      "hosts/_common/gui/display/sddm.nix"
      "hosts/_common/i18n"
      "hosts/_common/themes"
      "hosts/_common/services/openssh.nix"
      "hosts/_common/virtualisation/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
