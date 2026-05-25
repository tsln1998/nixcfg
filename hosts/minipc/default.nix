{ tools, ... }:
{
  imports =
    map tools.relative [
      "hosts/_common/base"
      "hosts/_common/i18n/locale.nix"
      "hosts/_common/services/openssh.nix"
      "hosts/_common/virtualisation/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.);
}
