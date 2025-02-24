{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "hosts/common/services/docker.nix"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  # services.crproxy.enable = true;

  system.stateVersion = "24.11";
}
