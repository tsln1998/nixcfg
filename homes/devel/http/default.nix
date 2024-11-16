{ mylib, ... }:
{
  imports = (mylib.scan ./.) ++ [ ../net ];
}
