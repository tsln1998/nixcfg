{
  lib,
  mylib,
  pkgs,
  ...
}:
{
  imports =
    [
      ./hardware.nix
      ./users.nix
    ]
    ++ (map mylib.relativeToRoot [
      "modules/base"
      "modules/base/desktop"
      "modules/base/server"
      "modules/boot/plymouth"
      "modules/gui"
      "modules/gui/desktop/plasma"
      "modules/gui/display/sddm"
      "modules/virtualisation/guest/vmware"
      "modules/virtualisation/host/docker"
      "modules/virtualisation/host/podman"
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

  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    defaultLocale = "zh_CN.UTF-8";
  };

  system.stateVersion = "24.05";
}
