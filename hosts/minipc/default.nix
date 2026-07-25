{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/i18n"
      "hosts/_common/gui/display/sddm.nix"
      "hosts/_common/gui/desktop/plasma.nix"
      "hosts/_common/kernel/plymouth.nix"
      "hosts/_common/themes"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
