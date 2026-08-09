{ lib, ... }:
{
  catppuccin = {
    sddm = {
      flavor = lib.mkDefault "latte";
    };
  };
}
