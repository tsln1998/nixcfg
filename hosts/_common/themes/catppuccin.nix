{ lib, ... }:
{
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "blue";

    sddm.flavor = lib.mkDefault "latte";

    cache = {
      enable = true;
    };
  };
}
