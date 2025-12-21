{ lib, ... }:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
  };
}
