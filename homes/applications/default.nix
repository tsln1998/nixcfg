{ mylib, ... }:
{
  imports = mylib.scan ./.;
}