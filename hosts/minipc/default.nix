{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common_/base"
      "hosts/_common_/themes"
      "hosts/_common_/i18n"
      "hosts/_nixos_/base"
      "hosts/_nixos_/i18n"
      "hosts/_nixos_/gui"
      "hosts/_nixos_/kernel/kmscon.nix"
      "hosts/_nixos_/kernel/plymouth.nix"
      "hosts/_nixos_/services/comin.nix"
      "hosts/_nixos_/services/openssh.nix"
      "hosts/_nixos_/themes"

      "users/_common_"
      "users/_nixos_"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
