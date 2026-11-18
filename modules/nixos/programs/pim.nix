{ config, lib, ... }:
lib.mkIf config.services.desktopManager.plasma6.enable {
  # The NixOS Plasma 6 module enables KDE PIM with mkDefault true.
  # Disable it by default to omit KMail, Kontact, and Merkuro while allowing
  # hosts to opt in explicitly.
  programs.kde-pim.enable = lib.mkOverride 999 false;
}
