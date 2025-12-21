{ tools, ... }:
{
  imports = (
    (map tools.relative [
      "home/common/global"
      "home/common/cli"
      "home/common/themes"
      "home/common/dev/nix.nix"
      "home/common/dev/go.nix"
      "home/common/dev/java.nix"
      "home/common/dev/rust.nix"
      "home/common/dev/python.nix"
      "home/common/dev/nodejs.nix"
      "home/common/dev/dotnet.nix"
      "home/common/ops/kubectl.nix"
      "home/common/ops/fluxcd.nix"
      "home/common/i18n/locale.nix"
    ])
    ++ (map tools.relative [
      "home/tsln/common/dev/git.nix"
    ])
    ++ (tools.scan ./.)
  );
}
