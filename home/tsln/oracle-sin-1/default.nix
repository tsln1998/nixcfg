{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli/shells"
      "home/tsln/_common/dev/git.nix"
      "home/tsln/_common/dev/dotfiles/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
