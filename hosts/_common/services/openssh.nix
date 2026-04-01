{ lib, ... }:
{
  services.openssh = {
    enable = true;
    extraConfig = lib.concatStringsSep "\n" [
      "ClientAliveInterval 30"
      "ClientAliveCountMax 10"
    ];
  };
}
