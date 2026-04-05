{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli/shell"
      "home/tsln/_common/dev/git.nix"
      "home/tsln/_common/dev/env/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
