{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/_common/global"
      "home/tsln/_common/cli/shells"
      "home/tsln/_common/cli/alternatives"
      "home/tsln/_common/cli/additionals"
      "home/tsln/_common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
