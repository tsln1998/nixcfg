{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common/base"
      "home/tsln/_common/cli"
      "home/tsln/_common/dev"
      "home/tsln/_common/ops"
      "home/tsln/_common/gui"
      "home/tsln/_common/i18n"
      "home/tsln/_common/themes"
    ])
    ++ (tools.scan ./.);
}
