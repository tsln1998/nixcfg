{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/apps/chromium.nix"
      "home/tsln/common/apps/firefox.nix"
      "home/tsln/common/apps/idea.nix"
      "home/tsln/common/apps/vscode.nix"
      "home/tsln/common/apps/qq.nix"
      "home/tsln/common/apps/wechat.nix"
      "home/tsln/common/apps/notion.nix"
      "home/tsln/common/apps/hoppscotch.nix"
      "home/tsln/common/desktop/plasma.nix"
      "home/tsln/common/i18n/fcitx.nix"
      "home/tsln/common/cli"
      "home/tsln/common/dev"
      "home/tsln/common/ops"
    ]
  );
}
