{ lib, ... }:
{
  catppuccin = {
    # GRUB
    grub.enable = lib.mkDefault true;

    # Boot Splash
    plymouth.enable = lib.mkDefault true;

    # Plasma Display Manager
    sddm.enable = lib.mkDefault true;
    sddm.flavor = lib.mkDefault "latte";
  };
}
