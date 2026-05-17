{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common/base"
      "home/tsln/_common/cli"
      "home/tsln/_common/cli/editors"
      "home/tsln/_common/dev/agents/codex.nix"
      "home/tsln/_common/dev/languages/bun.nix"
      "home/tsln/_common/dev/languages/cxx.nix"
      "home/tsln/_common/dev/languages/git.nix"
      "home/tsln/_common/dev/languages/go.nix"
      "home/tsln/_common/dev/languages/nix.nix"
      "home/tsln/_common/dev/languages/nodejs.nix"
      "home/tsln/_common/dev/languages/rust.nix"
      "home/tsln/_common/dev/languages/dotfiles"
      "home/tsln/_common/dev/libraries/openssl.nix"
      "home/tsln/_common/dev/managers/dotfiles/kubectl.nix"
      "home/tsln/_common/dev/managers/fluxcd.nix"
      "home/tsln/_common/dev/managers/kubectl.nix"
      "home/tsln/_common/dev/managers/nixos.nix"
      "home/tsln/_common/dev/utilities"
      "home/tsln/_common/i18n/zh-CN/locale.nix"
      "home/tsln/_common/themes"
    ])
    ++ (tools.scan ./.);
}
