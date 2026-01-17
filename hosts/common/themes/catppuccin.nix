{ lib, ... }:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "macchiato";
    accent = lib.mkDefault "blue";

    cache = {
      enable = true;
    };
  };
}
