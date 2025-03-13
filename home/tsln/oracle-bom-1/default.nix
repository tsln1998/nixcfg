{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/cli"
      "home/tsln/common/apps/firefox.nix"
      "home/tsln/common/apps/telegram.nix"
      "home/tsln/common/dev/nix.nix"
    ]
  );
}
