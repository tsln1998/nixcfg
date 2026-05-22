{ lib, ... }:
{
  programs.nano.enable = lib.mkDefault false;
}
