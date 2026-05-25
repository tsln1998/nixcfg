{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common/base"
      "home/tsln/_common/cli"
      "home/tsln/_common/dev/agents/codex.nix"
      "home/tsln/_common/dev/languages/cxx.nix"
      "home/tsln/_common/dev/languages/git.nix"
      "home/tsln/_common/dev/languages/go.nix"
      "home/tsln/_common/dev/languages/nodejs.nix"
      "home/tsln/_common/dev/languages/python.nix"
      "home/tsln/_common/dev/languages/rust.nix"
      "home/tsln/_common/dev/languages/dotfiles"
      "home/tsln/_common/dev/libraries/openssl.nix"
      "home/tsln/_common/dev/managers/docker.nix"
      "home/tsln/_common/dev/managers/fluxcd.nix"
      "home/tsln/_common/dev/managers/kubectl.nix"
      "home/tsln/_common/dev/managers/dotfiles"
      "home/tsln/_common/dev/utilities"
      "home/tsln/_common/i18n"
      "home/tsln/_common/themes"
    ])
    ++ (tools.scan ./.);
}
