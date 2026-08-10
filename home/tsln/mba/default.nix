{ tools, ... }:
{
  imports =
    (map tools.relative [
      "home/tsln/_common_/base"
      "home/tsln/_common_/cli/shells"
      "home/tsln/_common_/cli/monitors"
      "home/tsln/_common_/cli/replacements"
      "home/tsln/_common_/dev/agents/codex.nix"
      "home/tsln/_common_/dev/programs/git.nix"
      "home/tsln/_common_/dev/programs/direnv.nix"
      "home/tsln/_common_/themes"
      "home/tsln/_darwin_/gui"
      "home/tsln/_darwin_/i18n"
    ])
    ++ (tools.scan ./.);
}
