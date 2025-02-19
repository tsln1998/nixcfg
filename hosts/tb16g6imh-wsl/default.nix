{ tools, ... }:
{
  imports = (
    map tools.relative [
      "hosts/common/global"
      "users/tsln"
    ] ++ (
      tools.scan ./.
    )
  );

  system.stateVersion = "24.11";
}
