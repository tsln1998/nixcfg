{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/cli"
      "home/tsln/common/dev/nix.nix"
      "home/tsln/common/i18n/locale.nix"
    ]
  );
}
