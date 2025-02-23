{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "users/tsln"
    ]
    ++ (tools.scan ./.)
  );

  # services.crproxy.enable = true;

  system.stateVersion = "24.11";
}
