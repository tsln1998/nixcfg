{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common/base"
      "home/tsln/_common/cli/shells"
      "home/tsln/_common/dev/languages/git.nix"
      "home/tsln/_common/dev/languages/dotfiles/git.nix"
    ])
    ++ (tools.scan ./.);
}
