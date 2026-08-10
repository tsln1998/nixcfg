{ lib, ... }:
{
  catppuccin = {
    enable = true;
    autoEnable = false;

    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "blue";

    cache = {
      enable = true;
    };
  };
}
