{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli"
      "home/common/themes/papirus.nix"
      "home/common/themes/catppuccin.nix"
      "home/common/apps/bitwarden.nix"
      "home/common/apps/chromium.nix"
      "home/common/apps/dingtalk.nix"
      "home/common/apps/filelight.nix"
      "home/common/apps/flclash.nix"
      "home/common/apps/ghostty.nix"
      "home/common/apps/insomnia.nix"
      "home/common/apps/intellij.nix"
      "home/common/apps/konsole.nix"
      "home/common/apps/netease.nix"
      "home/common/apps/qq.nix"
      "home/common/apps/vlc.nix"
      "home/common/apps/vscode.nix"
      "home/common/apps/wechat.nix"
      "home/common/desktop/plasma.nix"
      "home/common/dev/dotnet.nix"
      "home/common/dev/go.nix"
      "home/common/dev/cxx.nix"
      "home/common/dev/java.nix"
      "home/common/dev/nix.nix"
      "home/common/dev/nodejs.nix"
      "home/common/dev/python.nix"
      "home/common/dev/rust.nix"
      "home/common/i18n/fcitx.nix"
      "home/common/i18n/fonts.nix"
      "home/common/i18n/locale.nix"
      "home/common/ops/docker.nix"
      "home/common/ops/fluxcd.nix"
      "home/common/ops/kubectl.nix"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
