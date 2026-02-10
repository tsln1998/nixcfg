{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/cli"
      "home/tsln/common/themes"
      "home/tsln/common/i18n"
      "home/tsln/common/apps/bitwarden.nix"
      "home/tsln/common/apps/chromium.nix"
      "home/tsln/common/apps/konsole.nix"
      "home/tsln/common/apps/libreoffice.nix"
      "home/tsln/common/apps/vscode.nix"
      "home/tsln/common/apps/lark.nix"
      "home/tsln/common/apps/datagrip.nix"
      "home/tsln/common/apps/filelight.nix"
      "home/tsln/common/apps/flclash.nix"
      "home/tsln/common/apps/insomnia.nix"
      "home/tsln/common/apps/netease.nix"
      "home/tsln/common/apps/qq.nix"
      "home/tsln/common/apps/vlc.nix"
      "home/tsln/common/apps/wechat.nix"
      "home/tsln/common/desktop/plasma.nix"
      "home/tsln/common/dev/git.nix"
      "home/tsln/common/dev/nix.nix"
      "home/tsln/common/dev/nodejs.nix"
      "home/tsln/common/dev/bun.nix"
      "home/tsln/common/ops/nixos.nix"
    ])
    ++ (tools.scan ./.)
  );
}
