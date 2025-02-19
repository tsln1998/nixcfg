{ tools, ... }:
{
  imports = (
    map tools.relative [
      "home/tsln/common"
    ]
  );
}
