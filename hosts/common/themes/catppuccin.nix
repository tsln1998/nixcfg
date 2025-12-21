{ lib, ... }:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "latte";
    accent = lib.mkDefault "blue";

    cache = {
      enable = true;
    };
  };
}
