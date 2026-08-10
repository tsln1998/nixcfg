{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common_/base"
      "home/tsln/_common_/cli"
      "home/tsln/_common_/dev"
      "home/tsln/_common_/ops"
      "home/tsln/_common_/themes"
      "home/tsln/_nixos_/gui"
      "home/tsln/_nixos_/i18n"
      "home/tsln/_nixos_/themes"
    ])
    ++ (tools.scan ./.);
}
