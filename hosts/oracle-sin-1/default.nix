{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/kernel/bbr.nix"
      "hosts/_common/i18n/timezone.nix"
      "hosts/_common/services/comin.nix"
      "hosts/_common/services/openssh.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
