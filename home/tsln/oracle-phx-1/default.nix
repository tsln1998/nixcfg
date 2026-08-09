{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common_/base"
      "home/tsln/_common_/cli/shells"
      "home/tsln/_common_/dev/languages/git.nix"
      "home/tsln/_common_/dev/languages/dotfiles/git.nix"
    ])
    ++ (tools.scan ./.);
}
