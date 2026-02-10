{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/cli/shells"
      "home/tsln/common/cli/alternatives"
      "home/tsln/common/cli/additionals"
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
