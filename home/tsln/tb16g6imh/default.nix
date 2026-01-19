{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli"
      "home/common/themes"
      "home/common/apps/bitwarden.nix"
      "home/common/apps/chromium.nix"
      "home/common/apps/konsole.nix"
      "home/common/apps/libreoffice.nix"
      "home/common/apps/vscode.nix"
      "home/common/apps/dingtalk.nix"
      "home/common/apps/filelight.nix"
      "home/common/apps/flclash.nix"
      "home/common/apps/insomnia.nix"
      "home/common/apps/netease.nix"
      "home/common/apps/qq.nix"
      "home/common/apps/vlc.nix"
      "home/common/apps/wechat.nix"
      "home/common/desktop/plasma.nix"
      "home/common/dev/nix.nix"
      "home/common/i18n"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev"
      "home/tsln/common/apps/chromium.nix"
      "home/tsln/common/apps/konsole.nix"
      "home/tsln/common/apps/vscode.nix"
    ])
    ++ (tools.scan ./.)
  );
}
