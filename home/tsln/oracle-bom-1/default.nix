{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli/shells"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
