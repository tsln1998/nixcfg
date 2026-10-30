{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common_/base"
      "hosts/_common_/i18n"
      "hosts/_nixos_/base"
      "hosts/_nixos_/kernel/bbr.nix"
      "hosts/_nixos_/services/gitops.nix"
      "hosts/_nixos_/services/openssh.nix"

      "users/_common_"
      "users/_nixos_"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
