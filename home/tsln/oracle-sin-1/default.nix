{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli/startship.nix"
      "home/common/cli/zsh.nix"
      "home/common/cli/atuin.nix"
      "home/common/dev/nix.nix"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
