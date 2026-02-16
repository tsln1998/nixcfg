{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli"
      "home/tsln/_common/themes"
      "home/tsln/_common/i18n"
      "home/tsln/_common/desktop/plasma"
      "home/tsln/_common/apps/bitwarden.nix"
      "home/tsln/_common/apps/chromium.nix"
      "home/tsln/_common/apps/datagrip.nix"
      "home/tsln/_common/apps/filelight.nix"
      "home/tsln/_common/apps/hoppscotch.nix"
      "home/tsln/_common/apps/insomnia.nix"
      "home/tsln/_common/apps/konsole.nix"
      "home/tsln/_common/apps/lark.nix"
      "home/tsln/_common/apps/libreoffice.nix"
      "home/tsln/_common/apps/netease.nix"
      "home/tsln/_common/apps/qq.nix"
      "home/tsln/_common/apps/vlc.nix"
      "home/tsln/_common/apps/vscode.nix"
      "home/tsln/_common/apps/wechat.nix"
      "home/tsln/_common/dev/bun.nix"
      "home/tsln/_common/dev/git.nix"
      "home/tsln/_common/dev/nix.nix"
      "home/tsln/_common/dev/nodejs.nix"
      "home/tsln/_common/ops/nixos.nix"
    ])
    ++ (tools.scan ./.)
  );
}
