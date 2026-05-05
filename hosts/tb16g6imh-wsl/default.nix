{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/global"
      "hosts/_common/i18n"
      "hosts/_common/themes"
      "hosts/_common/services/openssh.nix"
      "hosts/_common/services/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
