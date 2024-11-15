{ lib, ... }: {
  services.openssh.enable = lib.mkDefault true;
  services.openssh.settings.PermitRootLogin = lib.mkDefault "prohibit-password";
}
