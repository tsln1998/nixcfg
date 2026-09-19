{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common_/base"
      "home/tsln/_common_/cli/shells"
      "home/tsln/_common_/dev/programs/git.nix"
      "home/tsln/_nixos_/base"
    ])
    ++ (tools.scan ./.);
}
