{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/services/openssh.nix"
      "hosts/common/services/crproxy.nix"
      "hosts/common/services/caddy.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  system.stateVersion = "24.11";
}
