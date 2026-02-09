{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli/shells"
      "home/common/cli/alternatives"
      "home/common/cli/additionals"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
