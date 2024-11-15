{ lib, mylib, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./users.nix
  ] ++ (map mylib.relativeToRoot [
    "modules/base"
    "modules/base/desktop"
    "modules/base/server"
    "modules/gui"
    "modules/gui/desktop/plasma"
    "modules/gui/display/sddm"
    "modules/virtualisation/guest/vmware"
    "modules/shells"
    "modules/utils"
  ]);

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot.enable = true;
  };

  system.stateVersion = "24.05";
}
