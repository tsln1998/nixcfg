{ lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ../../modules/base/core
    ../../modules/base/desktop
    ../../modules/base/server
    ../../modules/gui/core
    ../../modules/gui/desktop/plasma
    ../../modules/gui/display/sddm
    ../../modules/shells
    ../../modules/utils
  ];

  virtualisation.vmware.guest.enable = true;

  services.xserver.videoDrivers = [ "vmware" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot.enable = true;
  };

  system.stateVersion = "24.05";
}
