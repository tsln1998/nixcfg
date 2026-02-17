{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli"
      "home/tsln/_common/themes"
      "home/tsln/_common/i18n/locale.nix"
      "home/tsln/_common/dev/bun.nix"
      "home/tsln/_common/dev/git.nix"
      "home/tsln/_common/dev/nix.nix"
      "home/tsln/_common/dev/nodejs.nix"
      "home/tsln/_common/ops/nixos.nix"
    ])
    ++ (tools.scan ./.)
  );
}
