{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli"
      "home/tsln/_common/themes"
      "home/tsln/_common/i18n/locale.nix"
    ])
    ++ (tools.scan ./.)
  );
}
