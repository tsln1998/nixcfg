{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/common/global"
      "home/common/cli"
      "home/common/dev/nix.nix"
    ]
    ++ (tools.scan ./.)
  );
}
