{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/cli"
      "home/tsln/common/dev"
      "home/tsln/common/i18n/locale.nix"
      "home/tsln/common/i18n/fcitx.nix"
    ]
  );
}
