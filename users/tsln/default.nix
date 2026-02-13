{ tools, ... }:
{
  imports = (
    map tools.relative [
      "users/_common"
    ]
    ++ (tools.scan ./.)
  );
}
