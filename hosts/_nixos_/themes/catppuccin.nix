{ lib, ... }:
{
  catppuccin = {
    grub.enable = lib.mkDefault true;

    plymouth.enable = lib.mkDefault true;

    sddm.enable = lib.mkDefault true;
    sddm.flavor = lib.mkDefault "latte";
  };
}
