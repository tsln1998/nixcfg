{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/i18n"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/docker.nix"
      "hosts/common/themes/catppuccin.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "25.11";
}
