{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/features/apps/chromium.nix"
      "home/tsln/common/features/apps/firefox.nix"
      "home/tsln/common/features/apps/idea.nix"
      "home/tsln/common/features/apps/vscode.nix"
      "home/tsln/common/features/desktop/plasma.nix"
      "home/tsln/common/features/i18n/fcitx.nix"
      "home/tsln/common/features/cli"
      "home/tsln/common/features/dev"
      "home/tsln/common/features/ops"
    ]
  );
}
