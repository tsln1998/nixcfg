{ lib, ... }:
{
  catppuccin = {
    enable = true;
    autoEnable = true;

    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "blue";

    cache = {
      enable = true;
    };
  };
}
