{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common/global"
      "home/tsln/common/features/cli"
      "home/tsln/common/features/dev/nix.nix"
    ]
  );
}
