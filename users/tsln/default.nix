{ tools, ... }:
{
  imports = (
    map tools.relative [
      "users/common"
    ]
    ++ (tools.scan ./.)
  );
}
