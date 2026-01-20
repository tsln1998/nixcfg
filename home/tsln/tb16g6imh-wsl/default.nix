{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli"
      "home/common/themes/catppuccin.nix"
      "home/common/dev/nix.nix"
      "home/common/dev/bun.nix"
      "home/common/dev/nodejs.nix"
      "home/common/i18n/locale.nix"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev"
    ])
    ++ (tools.scan ./.)
  );
}
